extends Control

signal confirm
signal turn_end
signal turn_advance(battler)
signal delay_end
signal screen_shake

@onready var panel_msg = $MessagePanel
@onready var panel_actions = $ActionPanel
@onready var panel_actions_grid = $ActionPanel/VBox/ActionGrid
@onready var panel_actions_name = $ActionPanel/VBox/ActorName
@onready var panel_actors = $ActorPanel
@onready var enemies = $CenterContainer/EnemySprites
@onready var timeline = $Timeline
@onready var delay_timer = $BaseDelay

var timeline_entry_script = preload("res://scenes/battle_logic/TimelineEntry.gd")

const msg_start = "Monsters have appeared!"
const msg_victory = "The monsters have been defeated!"
const msg_defeat = "The party has been defeated!"

var actor_battlers = []
var enemy_battlers = []
var turn_queue = []
var waiting_for_turn = false


# Called when the node enters the scene tree for the first time.
func _ready():
	panel_actions.hide()

func initial_setup(actors : Array):
	for enemy in enemies.get_children():
		enemy_battlers.append(enemy)
	set_actors(actors)
	setup_timeline()
	show_message(msg_start)
	await confirm
	waiting_for_turn = true
	
func _process(_delta):
	if waiting_for_turn:
		for e in turn_queue:
			e.action_value = max(0, e.action_value - 3)
		timeline.update_timeline(turn_queue)
		if turn_queue[0].action_value == 0:
			waiting_for_turn = false
			next_turn()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if delay_timer.time_left == 0:
			confirm.emit()
		
func set_actors(actors):
	for actor in actors:
		actor_battlers.append(actor)
		panel_actors.add_actor(actor)
		
		
func setup_timeline():
	var all_battlers = []
	all_battlers.append_array(actor_battlers)
	all_battlers.append_array(enemy_battlers)
	
	for b in all_battlers:
		var entry = timeline_entry_script.new()
		entry.setup(b, 150)
		timeline_insert(entry)
	timeline.update_timeline(turn_queue)
		
		
func timeline_insert(entry : TimelineEntry):
	for i in turn_queue.size():
		if entry.action_value < turn_queue[i].action_value:
			turn_queue.insert(i, entry)
			return
	turn_queue.append(entry)
	
	
func next_turn():
	#var next_entry = turn_queue[0]
	#var advance_amount = next_entry.action_value
	#for e in turn_queue:
	#	e.action_value -= advance_amount
	#timeline.update_timeline(turn_queue)
	
	var next_battler = turn_queue[0].battler
	if next_battler is BattlerActor:
		await take_actor_turn(next_battler)
		
	if next_battler is BattlerEnemy:
		await take_enemy_turn(next_battler)
	
	#await start_delay()
	#await turn_end
	panel_actions.hide()
	reposition_entry(150)
	waiting_for_turn = true
		
		
func take_actor_turn(actor : BattlerActor):
	panel_actions.show()
	panel_actions_name.text = actor.get_display_name()
	panel_actions_grid.get_child(0).grab_focus()
	await turn_end
		
func take_enemy_turn(enemy : BattlerEnemy):
	await show_message("%s attacks!" % enemy.get_display_name())
	screen_shake.emit()
	actor_battlers[0].take_damage(4)
	await show_message("%s attacks! %s takes 4 damage!" 
		% [enemy.get_display_name(), actor_battlers[0].display_name])
	turn_end.emit()

func reposition_entry(av : int):
	var entry = turn_queue.pop_front()
	timeline.update_timeline(turn_queue)
	entry.new_turn(av)
	timeline_insert(entry)
	timeline.update_timeline(turn_queue)
	
	
func show_message(msg : String):
	panel_msg.show_message(msg)
	await start_delay()
	await confirm
	panel_msg.hide()


func _on_button_attack_pressed():
	var attacker : Battler
	attacker = turn_queue[0].battler
	enemies.get_child(0).grab_focus()
	await confirm
	enemies.get_child(0).take_damage(5)
	show_message("%s attacks! %s takes 5 damage!" % 
		[turn_queue[0].battler.get_display_name(), enemies.get_child(0).get_display_name()])
	panel_actions.hide()
	await confirm
	turn_end.emit()

func start_delay(time = 0.4):
	delay_timer.start(time)
	await delay_timer.timeout
	return true

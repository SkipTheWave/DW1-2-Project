extends Control

@onready var action_value_label = $ActionValue
@onready var sprite = $Control/Sprite
@onready var cursor = $Cursor
@onready var actor_marker = $ActorMarker
@onready var enemy_marker = $EnemyMarker
@onready var disable_panel = $DisablePanel
var disabled : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	cursor.hide()
	
	
func setup(e : TimelineEntry):
	disabled = false
	disable_panel.hide()
	
	var b = e.battler
	sprite.texture = b.stats_data.sprite_timeline
	action_value_label.text = str(e.action_value)
	
	if b is BattlerActor:
		actor_marker.show()
		enemy_marker.hide()
	elif b is BattlerEnemy:
		actor_marker.hide()
		enemy_marker.show()
	
	
func setup_disabled():
	disabled = true
	disable_panel.show()
	

func _on_mouse_entered():
	if !disabled:
		cursor.show()
	
func _on_mouse_exited():
	cursor.hide()

func _on_focus_entered():
	_on_mouse_entered()

func _on_focus_exited():
	_on_mouse_exited()

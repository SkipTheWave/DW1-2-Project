extends Node

const SHAKE_FORCE := 30.0
const SHAKE_DECAY := 5.0

@export var battle_scene = preload("res://scenes/battle.tscn")

#@onready var canvas = $CanvasLayer
@onready var main_control = $Control
@onready var anim_player = $AnimationPlayer
@onready var camera = $Camera2D

var team_battlers = []
var recruited_battlers = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for actor in $Actors.get_children():
		if actor is BattlerActor:
			team_battlers.append(actor)

func battle_start():
	var battle = battle_scene.instantiate()
	main_control.add_child(battle)
	battle.initial_setup(team_battlers)
	battle.screen_shake.connect(screen_shake)
	
func screen_shake():
	anim_player.play("screen_shake")
	
func _on_button_pressed():
	battle_start()

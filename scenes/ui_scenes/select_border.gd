extends Control

@onready var anim_player = $AnimationPlayer
@onready var selected = $Selected

func _ready():
	_on_focus_exited()

func _on_focus_entered():
	anim_player.play("selected")

func _on_focus_exited():
	anim_player.stop()
	selected.modulate.a = 0.0

func _on_mouse_entered():
	_on_focus_entered()

func _on_mouse_exited():
	_on_focus_exited()

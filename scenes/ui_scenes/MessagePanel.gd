extends NinePatchRect

signal confirm

@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func show_message(msg):
	show()
	label.text = msg

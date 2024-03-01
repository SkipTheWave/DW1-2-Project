extends NinePatchRect

var actor_info_scene = preload("res://scenes/ui_scenes/actor_info_container.tscn")

func add_actor(actor : BattlerActor):
	var actor_info = actor_info_scene.instantiate()
	$HBox.add_child(actor_info)
	actor_info.setup(actor)
	actor.update_display.connect(actor_info.update_display)

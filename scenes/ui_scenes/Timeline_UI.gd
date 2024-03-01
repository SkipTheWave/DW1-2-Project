extends VBoxContainer

const MAX_TIMELINE_SIZE = 8

var timeline_entry_scene = preload("res://scenes/ui_scenes/timeline_entry_ui.tscn")

func update_timeline(queue : Array):
	for c in get_children():
		remove_child(c)
		c.queue_free()
		
	# make entry UI for each queue entry, up to 8; if there are slots left, fill them with empty entries
	for i in MAX_TIMELINE_SIZE:
		var entry_ui = timeline_entry_scene.instantiate()
		add_child(entry_ui)
		if i < queue.size():
			entry_ui.setup(queue[i])
		else:
			entry_ui.setup_disabled()

		

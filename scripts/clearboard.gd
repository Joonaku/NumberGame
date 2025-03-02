extends Button

func _on_Button_pressed() -> void:
	var tiles = get_tree().get_nodes_in_group("slotst")
	for n in tiles.size():
		if tiles[n].is_in_group("default"):
			tiles[n].set_animation("selected")
			tiles[n].remove_from_group("slotst")
			tiles[n].add_to_group("slots")
		else:
			tiles[n].set_animation("default")
			tiles[n].set_frame(0)
			tiles[n].stop()
			tiles[n].remove_from_group("slotst")
			tiles[n].add_to_group("slots")

extends Button

func _on_Button_pressed() -> void:
	
	if $"../../Timer".is_stopped():
		if get_parent().is_in_group("selected") == false && Global.selectedcards < 10:
			get_parent().play("selected")
			get_parent().add_to_group("selected")
			Global.selectedcards = Global.selectedcards + 1
			
		elif get_parent().is_in_group("selected"):
			get_parent().remove_from_group("selected")
			get_parent().set_animation("default")
			get_parent().set_frame(0)
			get_parent().stop()
			Global.selectedcards = Global.selectedcards - 1

extends Button

func _on_Button_pressed() -> void:
	if $"../../../Timer".is_stopped():
		self.remove_from_group("cards")
		
		if get_parent().is_in_group("cardW"):
			get_parent().play("2X")
			Global.win = Global.win * 2
			
			$"../../winnings".set_text("Current winnings: "+str(Global.win)+"€")
			$"../../../win/Label".set_text("You won "+str(Global.win)+" €")
			$"../../../win".visible = true
			
		elif get_parent().is_in_group("cardL"):
			get_parent().play("0X")
			Global.win = 0
			
			$"../../../Timer".start()

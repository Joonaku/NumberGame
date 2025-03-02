extends Button

var hits = 0

func _on_Button_pressed() -> void:
	if Global.balance >= Global.betamount:
		Global.balance = Global.balance - Global.betamount
		$"../Balance".set_text("Balance: "+str(Global.balance))
	elif Global.balance < Global.betamount:
		print("You don't have enough balance to make that bet.")
		return
	
	if get_tree().get_nodes_in_group("slotst").size() > 1:
		restartboard()
	$"../Timer".start()
	
func winCalc():
	match hits:
		3: Global.win = Global.betamount * 2
		4: Global.win = Global.betamount * 3
		5: Global.win = Global.betamount * 5
		6: Global.win = Global.betamount * 12.5
		7: Global.win = Global.betamount * 35
		8: Global.win = Global.betamount * 40
		9: Global.win = Global.betamount * 50
		10: Global.win = Global.betamount * 500
		
	print(Global.win)
	
	if Global.win > 0:
		$"../winningscreen".visible = true
		$"../winningscreen/Label".set_text("You Won:\n"+str(Global.win))
	hits = 0

func restartboard():
	
	var tiles = get_tree().get_nodes_in_group("slotst")
	for n in tiles.size():
		if tiles[n].is_in_group("selected"):
			tiles[n].set_animation("selected")
			tiles[n].remove_from_group("slotst")
			tiles[n].add_to_group("slots")
		else:
			tiles[n].set_animation("default")
			tiles[n].set_frame(0)
			tiles[n].stop()
			tiles[n].remove_from_group("slotst")
			tiles[n].add_to_group("slots")
			
func _on_betamount_pressed() -> void:
	var i = 40
	match Global.betamount:
		1.00:
			$"../betamount".text = "0.20"
			Global.betamount = 0.20
		0.20:
			$"../betamount".text = "0.40"
			Global.betamount = 0.40
		0.40:
			$"../betamount".text = "0.60"
			Global.betamount = 0.60
		0.60:
			$"../betamount".text = "0.80"
			Global.betamount = 0.80
		0.80:
			$"../betamount".text = "1.00"
			Global.betamount = 1.00

	$"../winnings/Label2".set_text(
	 str(Global.betamount * 500 ) + "\n" +
	 str(Global.betamount * 50.0) + "\n" +
	 str(Global.betamount * 40.0) + "\n" +
	 str(Global.betamount * 35.0) + "\n" +
	 str(Global.betamount * 12.5) + "\n" +
	 str(Global.betamount * 5.00) + "\n" +
	 str(Global.betamount * 3.00) + "\n" +
	 str(Global.betamount * 2))

func _on_Timer_timeout() -> void:
		var tiles = get_tree().get_nodes_in_group("slots")
		var rnd = tiles[randi() % tiles.size()]
		randomize()
		
		if rnd.is_in_group("selected"):
			rnd.play("default")
			hits = hits + 1
		else:
			rnd.play("slotmissed")
			
		rnd.remove_from_group("slots")
		rnd.add_to_group("slotst")
		
		if get_tree().get_nodes_in_group("slotst").size() == 10:
			$"../Timer".stop()
			winCalc()

func _on_Keep_winnings_pressed() -> void:
	restartboard()
	print("You won "+ str(Global.win))
	
	Global.balance = Global.balance + Global.win
	Global.win = 0
	$"../Balance".set_text("Balance: "+str(Global.balance))
	$"../winningscreen".visible = false

func _on_Double_pressed() -> void:
	$"../Doublescreen".visible = true
	$"../winningscreen".visible = false
	randomize()

func _on_Clearboard_pressed() -> void:
	Global.selectedcards = 0
	restartboard()
	
	var tiles = get_tree().get_nodes_in_group("slots")
	for n in tiles.size():
		tiles[n].set_animation("default")
		tiles[n].set_frame(0)
		tiles[n].stop()
		tiles[n].remove_from_group("slotst")
		#tiles[n].add_to_group("slots")
		tiles[n].remove_from_group("selected")
		

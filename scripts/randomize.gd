extends Node2D
var once = true

func _ready() -> void:
	if once == true:
		randomizecards()
		
func randomizecards():
		$"ColorRect/winnings".set_text("Current winnings: "+str(Global.win)+"€")
		once = false
		var cardsgroup = get_tree().get_nodes_in_group("cards")
		for i in 40:
			var rnd = randi() % 2
			randomize()
			
			if rnd == 0:
				cardsgroup[i].add_to_group("cardW")
			elif rnd == 1:
				cardsgroup[i].add_to_group("cardL")

func _on_keep_pressed() -> void:
	Global.balance = Global.balance + Global.win
	Global.win = 0
	showcards()
	$"win".visible = false
	$Timer.start()

func _on_Double_pressed() -> void:
	$"win".visible = false
	removecards()
	randomizecards()
	
func _on_Timer_timeout() -> void:
	self.visible = false
	once = true
	$Timer.stop()
	removecards()
	randomizecards()

func showcards():
	for i in get_tree().get_nodes_in_group("cards").size():
		var b = get_tree().get_nodes_in_group("cards")
		
		if b[i].is_in_group("cardW"):
			b[i].play("2X")
		else:
			b[i].play("0X")

func removecards():
	var cardsgroup = get_tree().get_nodes_in_group("cards")
	for i in 40:
		cardsgroup[i].stop()
		cardsgroup[i].remove_from_group("cardL")
		cardsgroup[i].remove_from_group("cardW")
		cardsgroup[i].set_frame(0)

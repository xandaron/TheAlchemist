extends Node2D

func _input(event):
	if event.is_action_pressed("quit"):
		if GlobalVariables.in_menu:
			GlobalVariables.in_menu = not GlobalVariables.in_menu
			$"../Camera".get_child(0).toggle_ui_type()
	elif event.is_action_pressed("menu"):
		GlobalVariables.paused = not GlobalVariables.paused
	elif event.is_action_pressed("heal_debug"):
		PlayerVariables.heal_player(100, 1000)
	elif event.is_action_pressed("potion_craft"):
		GlobalVariables.in_menu = not GlobalVariables.in_menu
		$"../Camera".get_child(0).toggle_ui_type()

extends Node2D

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit(0)

func _input(event):
	if event.is_action("quit"):
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	if event.is_action("menu") and event.is_pressed():
		GlobalVariables.pause = not GlobalVariables.pause

func _on_player_death():
	GlobalVariables.pause = true

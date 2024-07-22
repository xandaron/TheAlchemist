extends Node2D

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit(0)

func _input(event):
	if event.is_action("quit"):
		print("quit")
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)

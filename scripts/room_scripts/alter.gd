extends Node2D

signal alter_complete
signal placed_red
signal placed_blue

var state := 0
var interactable := false

func _input(event):
	if event.is_action_pressed("interact") and interactable:
		if PlayerVariables.carrying == PlayerVariables.CarryItems.BLUE_STATUE:
			state += 1
			get_child(2).visible = true
			PlayerVariables.drop_item()
			placed_blue.emit()
		elif PlayerVariables.carrying == PlayerVariables.CarryItems.RED_STATUE:
			state += 1
			get_child(1).visible = true
			PlayerVariables.drop_item()
			placed_red.emit()
		if state == 2:
			alter_complete.emit()

func _ready():
	get_child(1).visible = false
	get_child(2).visible = false

func _on_area_entered(_body):
	interactable = true

func _on_area_exited(_body):
	interactable = false

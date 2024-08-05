extends Node2D

signal trigger

var triggered := false
var interactable := false

const leaver_pull := preload("res://scenes/leaver_pull.tscn")

func _input(event):
	if event.is_action_pressed("interact") and interactable and not triggered:
		triggered = true
		get_child(0).texture = preload(
			"res://assets/textures/room_assets/triggers/leaver_side_down.png")
		add_child(leaver_pull.instantiate())
		trigger.emit()

func _on_trigger_entered(_body):
	interactable = true

func _on_trigger_exited(_body):
	interactable = false

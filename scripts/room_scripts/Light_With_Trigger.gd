extends Node2D

signal turn_on

func _on_light_trigger_entered(_body):
	turn_on.emit()

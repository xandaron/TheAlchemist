extends Node2D

signal turn_on
signal turn_off

func _on_area_entered(_body):
	turn_on.emit()

func _ready():
	for i in range(1, 5):
		turn_on.connect(get_child(i)._turn_on)
		turn_off.connect(get_child(i)._turn_off)

func _on_light_trigger_area_exited(_area):
	turn_off.emit()

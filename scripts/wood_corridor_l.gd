extends Node2D

signal turn_on
signal turn_off

func _ready():
	for i in range(0, 5):
		turn_on.connect(get_child(i)._turn_on)
		turn_off.connect(get_child(i)._turn_off)

func _on_area_2d_area_entered(_area):
	turn_on.emit()

func _on_area_2d_area_exited(_area):
	turn_off.emit()

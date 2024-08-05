extends Node2D

func _ready():
	_turn_off()

func _turn_on():
	get_child(0).enabled = true
	get_child(1).play("lit")

func _turn_off():
	get_child(0).enabled = false
	get_child(1).play("unlit")

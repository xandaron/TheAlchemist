extends Node2D

func _ready():
	var children := get_children()
	children[0].set_type(0)
	children[1].set_type(0)
	children[2].set_type(4)
	children[3].set_type(0)
	for i in range(4, 8):
		children[i]._turn_on()

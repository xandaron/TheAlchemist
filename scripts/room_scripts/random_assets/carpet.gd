extends Node2D

func _ready():
	var index := randi_range(0, 4)
	for child in get_children():
		child.set_type(index)

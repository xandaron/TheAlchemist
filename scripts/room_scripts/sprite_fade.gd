extends Node2D

class_name SpriteFade

@export var fade_distance = Vector2(0, 32)
@export var fade_y_offset = 0

func _process(_delta):
	var distance = PlayerVariables.position - global_position
	if distance.x > fade_distance.x or distance.x < -fade_distance.x or \
		 distance.y < -fade_distance.y or PlayerVariables.position.y > \
			fade_y_offset + global_position.y:
		modulate.a = 1
		return
	modulate.a = 0.5

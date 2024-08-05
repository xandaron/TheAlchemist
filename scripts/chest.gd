extends Node2D

const open_texture := preload("res://assets/textures/room_assets/furniture/chest_front_open.png")

const open_sound := preload("res://scenes/chest_open.tscn")

func _on_open_area_entered(_body):
	get_child(0).texture = open_texture
	get_child(2).collision_mask = 0
	GlobalVariables.give_player_random_reward(global_position)
	var temp := open_sound.instantiate()
	add_child(temp)

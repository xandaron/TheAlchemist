extends Node2D

func _on_area_entered(_area):
	PlayerVariables.attack_player(2, 0)
	PlayerVariables.push_player(get_child(0).global_position)
	

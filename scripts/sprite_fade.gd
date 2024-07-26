extends Node2D

func _process(_delta):
	if PlayerVariables.position.y > global_position.y:
		modulate.a = 1
		return
	var distance = (PlayerVariables.position - global_position).length()
	if distance >= 50:
		modulate.a = 1
		return
	modulate.a = distance / 50

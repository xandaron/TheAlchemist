extends TextureRect

func _process(_delta):
	get_child(0).get_child(0).offset.y = \
		62.5 * -(PlayerVariables.stamina - PlayerVariables.max_stamina) / PlayerVariables.max_stamina

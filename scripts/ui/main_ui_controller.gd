extends Control

func toggle_ui_type():
	var children := get_children()
	children[1].visible = not children[1].visible

func _ready():
	var children := get_children()
	children[1].visible = false
	children[0].visible = true

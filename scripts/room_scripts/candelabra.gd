extends Node2D

const lit_texture = preload("res://assets/textures/room_assets/lights/candelabra_lit.png")
const unlit_texture = preload("res://assets/textures/room_assets/lights/candelabra_unlit.png")

func _ready():
	_turn_off()

func _turn_on():
	get_child(0).enabled = true
	get_child(1).texture = lit_texture

func _turn_off():
	get_child(0).enabled = false
	get_child(1).texture = unlit_texture

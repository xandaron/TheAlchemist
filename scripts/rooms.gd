extends Node

var active_room_id: int
var entered_room_id: int

func _ready():
	var rooms := get_children()
	rooms[0].set_id(0, Vector2(128, 128))
	rooms[0].activate()
	active_room_id = 0

func _on_hit_targets(targets: Array[Node2D], damage: float):
	get_child(active_room_id)._on_hit_targets(targets, damage)

func _on_room_entered(id: int):
	print("entered room: ", id)
	entered_room_id = id

func _on_room_exited(id: int):
	if id == active_room_id:
		get_child(active_room_id).deactivate()
		get_child(entered_room_id).activate()
		active_room_id = entered_room_id

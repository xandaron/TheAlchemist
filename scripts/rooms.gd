extends Node

var active_room := 0

func _on_hit_targets(targets: Array[Node2D], damage: float):
	var room: Room = get_child(active_room)
	room._on_hit_targets(targets, damage)

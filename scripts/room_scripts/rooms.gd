extends Node

var active_room_id: int
var rooms_cleared: int
var difficulty := 1
const BASE_HEAL_PER_DIFFICULTY_LEVEL := 10.0
var heal_per_difficulty_level := BASE_HEAL_PER_DIFFICULTY_LEVEL

const door_open := preload("res://scenes/open_door.tscn")
const door_slam := preload("res://scenes/door_slam.tscn")

func _input(event):
	if event.is_action_pressed("end this please"):
			get_child(active_room_id).complete()
			get_child(active_room_id).clear_condition_complete = true
			for mob in get_child(active_room_id).mobs:
				get_child(active_room_id)._on_mob_death(mob.id, mob.type)
			get_child(active_room_id).room_cleared()

func _ready():
	var rooms := get_children()
	for i in range(0, rooms.size()):
		rooms[i].set_id(i)
		rooms[i].entered.connect(_on_room_entered)
		rooms[i].clear_condition_staisfied.connect(_on_condition_satisfied)
		rooms[i].clear.connect(_on_room_cleared)

func _on_hit_targets(targets: Array[Node2D], damage: float, elements: int):
	get_child(active_room_id)._on_hit_targets(targets, damage, elements)

func _on_room_cleared():
	PlayerVariables.heal_player(0, heal_per_difficulty_level * difficulty)
	var temp := door_open.instantiate()
	add_child(temp)
	rooms_cleared += 1
	if rooms_cleared % 4 == 0:
		difficulty += 1

func _on_condition_satisfied():
	print("satisfied")
	$"../Player".get_child(4).enabled = false

func _on_room_entered(id: int):
	get_child(active_room_id).turn_off_lights()
	var temp := door_slam.instantiate()
	add_child(temp)
	active_room_id = id
	$"../Player".get_child(4).enabled = true

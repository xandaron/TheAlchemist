extends Node

enum Mob_Types {GOBLIN}

var paused := false

var goblin: PackedScene = preload("res://scenes/goblin.tscn")

var corridor_size := Vector2(15, 32)
var room_size := Vector2(128, 128)

var double_sided_toppers: Array[Texture2D]
var double_toppers: Array[Texture2D]
var short_double_topper: Array[Texture2D]

var moss_wall: Texture2D = preload("res://assets/textures/room_assets/moss_brick_wall.png")

func _ready():
	for i in range(0, 6):
		double_toppers.append(
			load("res://assets/textures/room_assets/wall_top_double_0" + str(i) + ".png"))
		double_sided_toppers.append(
			load("res://assets/textures/room_assets/wall_top_double_sided_0" + str(i) + ".png"))
	for i in range(0, 4):
		short_double_topper.append(
			load("res://assets/textures/room_assets/wall_top_short_double_0" + str(i) + ".png"))

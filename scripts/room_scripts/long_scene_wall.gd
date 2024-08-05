extends SpriteFade

signal room_entered
signal room_activated
signal room_cleared

const single_horizontal_wall := preload(
	"res://scenes/room_components/walls/horizontal_wall_1.tscn")
const double_horizontal_wall := preload(
	"res://scenes/room_components/walls/horizontal_wall_2.tscn")
const single_horizontal_door := preload(
	"res://scenes/room_components/doors/single_horizontal_door.tscn")
const double_horizontal_door := preload(
	"res://scenes/room_components/doors/double_horizontal_door.tscn")

const single_vertical_wall := preload("res://scenes/room_components/walls/vertical_wall_1.tscn")
const double_vertical_wall := preload("res://scenes/room_components/walls/vertical_wall_2.tscn")
const single_vertical_door := preload(
	"res://scenes/room_components/doors/single_vertical_door.tscn")
const double_vertical_door := preload(
	"res://scenes/room_components/doors/double_vertical_door.tscn")

@export var left := Vector2(-72, 0)
@export var right := Vector2(72, 0)
@export var centre := Vector2(0, 0)

@export var orientation := 0

func set_type(type: int):
	if type & 0b001:
		spawn_single_door(left)
	else:
		spawn_single_wall(left)
	if type & 0b010:
		spawn_single_door(right)
	else:
		spawn_single_wall(right)
	if type & 0b100:
		spawn_double_door()
	else:
		spawn_double_wall()

func spawn_single_wall(pos: Vector2):
	var w
	if orientation == 0:
		w = single_horizontal_wall.instantiate()
		w.get_child(2).visible = false
	else:
		w = single_vertical_wall.instantiate()
	w.position = pos
	add_child(w)

func spawn_double_wall():
	var w
	if orientation == 0:
		w = double_horizontal_wall.instantiate()
		w.get_child(3).visible = false
	else:
		w = double_vertical_wall.instantiate()
	w.position = centre
	add_child(w)

func spawn_single_door(pos: Vector2):
	var d 
	if orientation == 0:
		d = single_horizontal_door.instantiate()
	else:
		d = single_vertical_door.instantiate()
	d.position = pos
	room_activated.connect(d._on_room_activated)
	room_cleared.connect(d._on_room_cleared)
	add_child(d)

func spawn_double_door():
	var d 
	if orientation == 0:
		d = double_horizontal_door.instantiate()
	else:
		d = double_vertical_door.instantiate()
		d.z_index = 1
	d.position = centre
	room_activated.connect(d._on_room_activated)
	room_cleared.connect(d._on_room_cleared)
	add_child(d)

func _on_room_entered(_body):
	room_entered.emit()

func _on_room_activation():
	room_activated.emit()

func _on_room_cleared():
	room_cleared.emit()

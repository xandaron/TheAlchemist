extends Area2D

class_name Potion

signal hit_targets(targets: Array[Node2D], damage: float)

var direction: Vector2
var damage: float
var speed: float
var fly_time: float

func initalize(pos: Vector2, dir: Vector2, dam: float, spe: float, time: float):
	position = pos
	direction = dir
	damage = dam
	speed = spe
	fly_time = time

func destroy():
	visible = false
	for child in get_children():
		child.queue_free()
	call_deferred("queue_free")

func _physics_process(delta):
	if GlobalVariables.paused:
		return
	position += direction * speed * delta
	rotate((speed / 10) * delta)
	if has_overlapping_bodies():
		hit_targets.emit(get_overlapping_bodies(), damage)
		destroy()
		return
	fly_time -= delta
	if fly_time <= 0.0:
		destroy()

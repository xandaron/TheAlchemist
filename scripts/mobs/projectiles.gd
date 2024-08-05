extends Area2D

class_name Projectile

var fly_time: float
var direction: Vector2
var speed: float
var damage: float
var elements: int

func initalize(pos: Vector2, dir: Vector2):
	position = pos
	direction = dir

func pre_destroy():
	pass

func destroy():
	pre_destroy()
	visible = false
	call_deferred("queue_free")

func check_for_collision():
	if has_overlapping_areas():
		PlayerVariables.attack_player(int(damage), elements)
		destroy()
		return
	elif has_overlapping_bodies():
		destroy()
		return

func _physics_process(delta):
	if GlobalVariables.paused:
		return
	position += direction * speed * delta
	rotate((speed / 10) * delta)
	check_for_collision()
	fly_time -= delta
	if fly_time <= 0.0:
		destroy()

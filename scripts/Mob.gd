extends CharacterBody2D

class_name Mob

signal attack_player(damage: float)

signal death(id: int)

var id: int
var health: float
var speed: float
var attack_damage: float
var cooldown_timer := 0.0
var within_attack_range := false
var active: bool

func activate():
	active = true

func deactivate():
	active = false

func die():
	visible = false
	for child in get_children():
		child.queue_free()
	call_deferred("queue_free")
	death.emit(id)

func attack():
	attack_player.emit(attack_damage)

func initalize(uid: int, pos: Vector2, act: bool):
	id = uid
	position = pos
	active = act

func _on_attack_area_entered(_body):
	within_attack_range = true

func _on_attack_area_exited(_body):
	within_attack_range = false

func _on_potion_hit(damage: float):
	health -= damage
	if health <= 0.0:
		die()

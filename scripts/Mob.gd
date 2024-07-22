extends CharacterBody2D

signal attack_player(damage: float)

const BASE_HEALTH := 100.0
var health := BASE_HEALTH

const BASE_SPEED := 100.0
var speed := BASE_SPEED

const BASE_ATTACK_DELAY := 0.5
var attack_cooldown := BASE_ATTACK_DELAY
var cooldown_timer := 0.0

const BASE_DAMAGE := 10.0
var damage := BASE_DAMAGE

var within_attack_range := false

func attack():
	emit_signal("attack_player", damage)
	cooldown_timer = attack_cooldown

func move(target: Vector2, delta: float):
	move_and_collide((target - position).normalized() * speed * delta)

func _physics_process(delta):
	if cooldown_timer > 0.0:
		cooldown_timer -= delta
	elif within_attack_range:
		attack()

func _on_attack_area_entered(_body):
	within_attack_range = true

func _on_attack_area_exited(_body):
	within_attack_range = false

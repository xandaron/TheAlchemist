extends CharacterBody2D

const BASE_HEALTH := 100.0
var health := BASE_HEALTH
const BASE_SPEED := 300.0
var speed := BASE_SPEED

const BASE_IMMUNITY_TIME := 1.0
var immunity_time := BASE_IMMUNITY_TIME
var immunity_timer := 0.0

func _physics_process(delta):
	if immunity_timer > 0.0:
		immunity_timer -= delta
	var direction := Vector2(0.0, 0.0)	
	if Input.is_action_pressed("move up"):
		direction.y -= 1.0
	if Input.is_action_pressed("move down"):
		direction.y += 1.0
	if Input.is_action_pressed("move left"):
		direction.x -= 1.0
	if Input.is_action_pressed("move right"):
		direction.x += 1.0
	direction = direction.normalized()
	var collision_info = move_and_collide(direction * speed * delta)
	while collision_info:
		var normal := collision_info.get_normal()
		collision_info = move_and_collide(Vector2(normal.y, -normal.x) * \
			collision_info.get_remainder().length() * \
			direction.cross(normal))
	Player_Variables.current_position = position

func _on_attack_player(damage: float, _status_effect: int):
	if immunity_timer <= 0.0:
		immunity_timer = immunity_time
		health -= damage
		print("Ouch! Damage: ", damage, " HP: ", health)

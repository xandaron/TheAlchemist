extends CharacterBody2D

class_name Mob

signal death(id: int, type: MobVariables.Types)

var id: int
var health: float
var speed: float
var attack_damage: int
var cooldown_time: float
var cooldown_timer := 0.0
var within_attack_range := false
var element_resistant: int
var element_vulnerable: int
var type: MobVariables.Types
var distance_from_player: float
var spawned := false
var direction: Vector2

const death_sound := preload("res://scenes/death_sound.tscn")

func die():
	death.emit(id, type)
	var temp := death_sound.instantiate()
	get_parent().add_child(temp)

func weaken():
	if type == MobVariables.Types.CULTIST:
		return
	modulate.a = 0.4
	health = 1

func attack():
	pass

func initalize(mob_id: int, pos: Vector2):
	id = mob_id
	position = pos

func set_stats():
	pass

func _ready():
	death.connect($".."._on_mob_death)
	set_stats()
	get_child(0).play("spawn")

func _physics_process(delta):
	if GlobalVariables.paused or not spawned:
		return
	var distanceFromPlayer = PlayerVariables.position - global_position
	if distanceFromPlayer.length() > distance_from_player:
		direction = distanceFromPlayer.normalized()
		if direction == Vector2(0, 0):
			get_child(0).play("idle")
			return
		if abs(direction.x) >= abs(direction.y):
			if direction.x < 0:
				get_child(0).play("left")
			else:
				get_child(0).play("right")
		else:
			if direction.y < 0:
				get_child(0).play("up")
			else:
				get_child(0).play("down")
		var collision_info = move_and_collide(direction * speed * delta)
		var collision_count := 1
		while collision_info and collision_count < 5:
			var normal := collision_info.get_normal()
			collision_info = move_and_collide(Vector2(normal.y, -normal.x) * \
				collision_info.get_remainder().length() * direction.cross(normal))
			collision_count += 1
	if cooldown_timer > 0.0:
		cooldown_timer -= delta
	elif within_attack_range:
		attack()
		cooldown_timer = cooldown_time

func _on_spawn_finished():
	if not spawned:
		spawned = true
		get_child(0).play("idle")

func _on_attack_area_entered(_body):
	within_attack_range = true

func _on_attack_area_exited(_body):
	within_attack_range = false

func _on_potion_hit(damage: float, elements: int):
	if element_resistant & elements:
		damage /= 2
	if element_vulnerable & elements:
		damage *= 2
	health -= damage
	if health <= 0.0:
		die()

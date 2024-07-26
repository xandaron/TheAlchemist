extends CharacterBody2D

signal death

@export var throwable: PackedScene

func attack():
	var potion := throwable.instantiate()
	potion.initalize(position, get_local_mouse_position().normalized(), 50.0, 100.0, 1.0)
	potion.hit_targets.connect($"../Rooms"._on_hit_targets)
	get_parent().add_child(potion)
	PlayerVariables.cooldown_timer = PlayerVariables.cooldown

func _ready():
	PlayerVariables.position = position

func _input(event):
	if event.is_action("attack") and event.is_pressed() and \
		PlayerVariables.cooldown_timer <= 0.0:
		attack()

func _physics_process(delta):
	if GlobalVariables.paused:
		return
	if PlayerVariables.cooldown_timer > 0.0:
		PlayerVariables.cooldown_timer -= delta
	if PlayerVariables.immunity_timer > 0.0:
		PlayerVariables.immunity_timer -= delta
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
	var collision_info = move_and_collide(direction * PlayerVariables.speed * delta)
	while collision_info:
		var normal := collision_info.get_normal()
		collision_info = move_and_collide(Vector2(normal.y, -normal.x) * \
			collision_info.get_remainder().length() * \
			direction.cross(normal))
	PlayerVariables.position = global_position

func _on_attack_player(damage: float):
	if PlayerVariables.immunity_timer <= 0.0:
		PlayerVariables.immunity_timer = PlayerVariables.immunity_time
		PlayerVariables.health -= damage
		print("Damage: ", damage, " HP: ", PlayerVariables.health)
		if PlayerVariables.health <= 0:
			death.emit()

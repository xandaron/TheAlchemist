extends CharacterBody2D

const potion_scene := preload("res://scenes/player/potion.tscn")
const after_image := preload("res://scenes/player/player_after_image.tscn")

const light := preload("res://player_light.tscn")

func dash():
	if PlayerVariables.stamina < 0.0:
		return
	var origin := global_position
	move_and_collide(PlayerVariables.direction * PlayerVariables.dash_distance)
	PlayerVariables.stamina -= PlayerVariables.dash_cost
	PlayerVariables.stamina_regen_timer = PlayerVariables.stamina_regen_delay
	var temp = after_image.instantiate()
	temp.global_position = origin
	get_parent().add_child(temp)
	temp.life_time = 0.3
	temp = after_image.instantiate()
	temp.global_position = (global_position + origin) * 0.5
	get_parent().add_child(temp)

func attack():
	var potion := potion_scene.instantiate()
	var camera_position = get_child(0).global_position
	potion.initalize(camera_position, (get_global_mouse_position() - camera_position).normalized())
	potion.hit_targets.connect($"../Rooms"._on_hit_targets)
	get_parent().add_child(potion)
	PlayerVariables.cooldown_timer = PlayerVariables.cooldown

func _ready():
	PlayerVariables.position = get_child(0).global_position
	get_child(0).play("idle")
	PlayerVariables.move_player.connect(_on_move_player)

func _on_move_player(dir: Vector2):
	global_position += dir

func _input(event):
	if GlobalVariables.in_menu or GlobalVariables.paused:
		return
	if event.is_action_pressed("attack") and PlayerVariables.cooldown_timer <= 0.0:
		attack()
	elif event.is_action_pressed("dash"):
		dash()
	elif event.is_action_pressed("reset light"):
		get_child(4).queue_free()
		var new_light := light.instantiate()
		add_child(new_light)
		new_light.enabled = true
		new_light.visible = true

func _physics_process(delta):
	if GlobalVariables.paused or GlobalVariables.in_menu:
		return
	if PlayerVariables.speed == PlayerVariables.exhausted_speed:
		get_child(0).speed_scale = PlayerVariables.exhausted_speed / PlayerVariables.normal_speed
	else:
		get_child(0).speed_scale = 1.0
	if PlayerVariables.direction == Vector2(0, 0):
		get_child(0).play("idle")
		get_child(5).stop()
		return
	if abs(PlayerVariables.direction.x) >= abs(PlayerVariables.direction.y):
			if PlayerVariables.direction.x < 0:
				get_child(0).play("left")
			else:
				get_child(0).play("right")
	else:
		if PlayerVariables.direction.y < 0:
			get_child(0).play("up")
		else:
			get_child(0).play("down")
	get_child(5).play(get_child(5).get_playback_position())
	var dir = PlayerVariables.direction.normalized()
	var collision_info = move_and_collide(dir * PlayerVariables.speed * delta)
	var collision_count := 0
	while collision_info and collision_count < 5:
		collision_count += 1
		var normal := collision_info.get_normal()
		collision_info = move_and_collide(Vector2(normal.y, -normal.x) * \
			collision_info.get_remainder().length() * \
			dir.cross(normal))
	PlayerVariables.position = get_child(0).global_position

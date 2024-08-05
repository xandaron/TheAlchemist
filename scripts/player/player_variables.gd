extends Node

signal container_state_change(int)
signal move_player(Rect2)

var position := Vector2(0.0, 0.0)

var encumbered := false
enum CarryItems {NONE, RED_STATUE, BLUE_STATUE}
var carrying: CarryItems

var container_state := 0
var fixing_container := false

const BASE_MAX_HEALTH := 100.0
var max_health := BASE_MAX_HEALTH
var health := max_health

const BASE_TIME_TO_FIX := 1.0
var time_to_fix := BASE_TIME_TO_FIX
var fix_timer := 0.0

const BASE_MAX_STAMINA := 90.0
var max_stamina := BASE_MAX_STAMINA
var stamina := max_stamina

const BASE_STAMINA_REGEN_DELAY := 0.5
var stamina_regen_delay := BASE_STAMINA_REGEN_DELAY
var stamina_regen_timer := 0.0

const BASE_STAMINA_REGEN_PER_SECOND := 10.0
var stamina_regen_per_second := BASE_STAMINA_REGEN_PER_SECOND

const BASE_DASH_COST := 30.0
var dash_cost := BASE_DASH_COST

const BASE_DASH_DISTANCE := 40.0
var dash_distance := BASE_DASH_DISTANCE

const BASE_CONTAINER_LEVELS := 4
var container_levels := BASE_CONTAINER_LEVELS

const BASE_HEALTH_DRAIN_PER_SECOND_PER_LEVEl := 2.0
var health_drain_per_second_per_level := BASE_HEALTH_DRAIN_PER_SECOND_PER_LEVEl

const BASE_NORMAL_SPEED := 100.0
var normal_speed := BASE_NORMAL_SPEED

const BASE_EXHAUSTED_SPEED := 40.0
var exhausted_speed := BASE_EXHAUSTED_SPEED

var speed := normal_speed

const BASE_THROW_SPEED := 100.0
var throw_speed := BASE_THROW_SPEED

const BASE_COOLDOWN := 0.5
var cooldown := BASE_COOLDOWN
var cooldown_timer := 0.0

const BASE_IMMUNITY_TIME := 1.0
var immunity_time := BASE_IMMUNITY_TIME
var immunity_timer := 0.0

var direction: Vector2

var left_held := false
var right_held := false
var up_held := false
var down_held := false

func pick_up(item: CarryItems):
	carrying = item
	encumbered = true

func drop_item():
	carrying = CarryItems.NONE
	encumbered = false

func die():
	GlobalVariables.paused = true

func push_player(caller_position: Vector2):
	move_player.emit((position - caller_position).normalized() * 10)

func heal_player(container_heal: int, health_heal: float):
	container_state -= container_heal
	health += health_heal
	if container_state < 0:
		container_state = 0
	if health > max_health:
		health = max_health
	container_state_change.emit(container_state)

func attack_player(container_damage: int, _element: int):
	if immunity_timer <= 0.0:
		immunity_timer = immunity_time
		container_state += container_damage
		if container_state > container_levels:
			health = 0.0
			container_state = container_levels + 1
			die()
		container_state_change.emit(container_state)

func _input(event):
	if event.is_action_pressed("heal") and not fixing_container:
		fixing_container = true
		fix_timer = time_to_fix
	if event.is_action_released("heal"):
		fixing_container = false
	if event.is_action_pressed("move up") and not up_held:
		up_held = true
		direction.y -= 1.0
	if event.is_action_pressed("move down") and not down_held:
		down_held = true
		direction.y += 1.0
	if event.is_action_pressed("move left") and not left_held:
		left_held = true
		direction.x -= 1.0
	if event.is_action_pressed("move right") and not right_held:
		right_held = true
		direction.x += 1.0
	if event.is_action_released("move up") and up_held:
		up_held = false
		direction.y += 1.0
	if event.is_action_released("move down") and down_held:
		down_held = false
		direction.y -= 1.0
	if event.is_action_released("move left") and left_held:
		left_held = false
		direction.x += 1.0
	if event.is_action_released("move right") and right_held:
		right_held = false
		direction.x -= 1.0

func _process(delta):
	if GlobalVariables.paused:
		return
	if fixing_container:
		fix_timer -= delta
		if fix_timer <= 0.0:
			heal_player(4, 0)
			fixing_container = false
	if container_state != 0:
		health -= container_state * health_drain_per_second_per_level * delta
		if health <= 0:
			die()
	if cooldown_timer > 0.0:
		cooldown_timer -= delta
	if immunity_timer > 0.0:
		immunity_timer -= delta
	if stamina_regen_timer > 0.0:
		stamina_regen_timer -= delta
	if stamina_regen_timer <= 0.0 and stamina < max_stamina:
		stamina += stamina_regen_per_second * delta
		if stamina > max_stamina:
			stamina = max_stamina
	if stamina < 0 or encumbered or fixing_container:
		speed = exhausted_speed
	else:
		speed = normal_speed

extends Node

class_name Room

signal entered(id)
signal activate
signal clear_condition_staisfied
signal clear

var reward_chest := preload("res://scenes/room_components/item_chest.tscn")

var size := Vector2(15, 32)

var activated := false
var cleared := false
var id: int
var mobs: Array[Mob]
var mobs_count:= 0
var spawn_region: Array[Rect2]
var difficulty: int
var reward_spawn: Vector2
var clear_condition_complete := false

func turn_off_lights():
	pass

func set_id(uid: int):
	id = uid

func complete():
	get_child(0).enabled = false
	clear_condition_complete = true
	clear_condition_staisfied.emit()
	for mob in mobs:
		mob.weaken()

func set_spawn():
	pass

func set_difficulty(diff: int):
	difficulty = diff

func generate_spawn_pos():
	var region: Rect2 = spawn_region.pick_random()
	var spawn := Vector2(region.position.x + (region.size.x * randf()), 
		region.position.y + (region.size.y * randf()))
	return spawn

func spawn_reward():
	var chest := reward_chest.instantiate()
	chest.position = reward_spawn
	add_child(chest)

func spawn_mob(mob_type: MobVariables.Types):
	var mob
	if mob_type == MobVariables.Types.MIMIC:
		mob = MobVariables.mimic.instantiate()
	if mob_type == MobVariables.Types.MIST:
		mob = MobVariables.mist.instantiate()
	if mob_type == MobVariables.Types.CULTIST:
		mob = MobVariables.cultist.instantiate()
	mob.position = generate_spawn_pos()
	mobs.append(mob)
	add_child(mob)
	mob.id = mobs_count
	mobs_count += 1

func room_cleared():
	cleared = true
	clear.emit()
	spawn_reward()

func get_ready():
	pass

func _ready():
	get_child(0).enabled = true
	get_ready()

func _on_mob_death(mob_id: int, type: MobVariables.Types):
	for i in range(0, mobs.size()):
		if mobs[i].id == mob_id:
			mobs[i].queue_free()
			mobs.remove_at(i)
			break
	if not clear_condition_complete:
		if type == MobVariables.Types.CULTIST:
			spawn_mob(MobVariables.Types.MIMIC)
		else:
			spawn_mob(type)

func _on_hit_targets(targets: Array[Node2D], damage: float, elements: int):
	if cleared:
		return
	for target in targets:
		for mob in mobs:
			if mob == null:
				continue
			if mob.name == target.name:
				mob._on_potion_hit(damage, elements)
				break
	if mobs.size() == 0 and clear_condition_complete:
		room_cleared()

func on_activation():
	pass

func _on_room_entered():
	if not activated:
		call_deferred("set_spawn")
		activated = true
		on_activation()
		entered.emit(id)
		activate.emit()

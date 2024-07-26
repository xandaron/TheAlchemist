extends Node

class_name Room

signal room_entered
signal room_exited

var size := Vector2(15, 32)

var respawn := true
var id := 0
var light_count := 1
var lit_count := 0
var mobs: Array[Mob]
var spawn_region: Array[Rect2]

func set_id(uid: int, s: Vector2):
	id = uid
	size = s

func set_spawn():
	spawn_region.append(Rect2(-80, -80, 60, 60))
	spawn_mob(GlobalVariables.Mob_Types.GOBLIN)

func activate():
	for mob in mobs:
		mob.activate()

func deactivate():
	for mob in mobs:
		mob.deactivate()

func generate_spawn_pos():
	var region: Rect2 = spawn_region.pick_random()
	return Vector2(region.position.x + (region.size.x * randf()), 
		region.position.y + (region.size.y * randf()))

func spawn_mob(mob_type: GlobalVariables.Mob_Types):
	var mob
	if mob_type == GlobalVariables.Mob_Types.GOBLIN:
		mob = GlobalVariables.goblin.instantiate()
	mob.initalize(mobs.size(), generate_spawn_pos(), true)
	mob.attack_player.connect($"../../Player"._on_attack_player)
	mobs.append(mob)
	add_child(mob)

func _on_mob_death(mob_id: int):
	mobs.remove_at(mob_id)
	if respawn:
		spawn_mob(GlobalVariables.Mob_Types.GOBLIN)

func _on_hit_targets(targets: Array[Node2D], damage: float):
	for target in targets:
		for mob in mobs:
			if mob.name == target.name:
				mob._on_potion_hit(damage)
				break

func _on_light_lit(_body):
	lit_count += 1
	if lit_count == light_count:
		respawn = false

func _on_room_entered(_area):
	print("entered: ", id)
	room_entered.emit(id)

func _on_room_exited(_area):
	print("exited: ", id)
	room_exited.emit(id)

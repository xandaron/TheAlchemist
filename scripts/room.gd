extends Node

class_name Room

var mobs: Array[Mob]
var spawn_region: Array[Rect2]

func generate_spawn_pos():
	var region: Rect2 = spawn_region.pick_random()
	return Vector2(region.position.x + (region.size.x * randf()), 
		region.position.y + (region.size.y * randf()))

func spawn_mob(mob_type: GlobalVariables.Mob_Types):
	var mob
	if mob_type == GlobalVariables.Mob_Types.GOBLIN:
		mob = GlobalVariables.goblin.instantiate()
	mob.initalize(mobs.size(), generate_spawn_pos())
	mob.attack_player.connect($"../../Player"._on_attack_player)
	mobs.append(mob)
	add_child(mob)

func _on_mob_death(id: int):
	mobs.remove_at(id)
	spawn_mob(GlobalVariables.Mob_Types.GOBLIN)

func _ready():
	spawn_region.append(Rect2(200, 200, 100, 100))
	spawn_mob(GlobalVariables.Mob_Types.GOBLIN)

func _on_hit_targets(targets: Array[Node2D], damage: float):
	for target in targets:
		for mob in mobs:
			if mob.name == target.name:
				mob._on_potion_hit(damage)
				break

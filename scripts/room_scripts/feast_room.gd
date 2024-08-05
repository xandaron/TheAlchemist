extends Room

var light_count := 4
var lit_count := 0

@export var left: int
@export var right: int
@export var top: int
@export var bottom: int

func turn_off_lights():
	for i in range(11, 11 + 4):
		var child := get_child(i)
		child.get_child(1)._turn_off()
		child.get_child(2)._turn_off()

func set_spawn():
	spawn_region.append(Rect2(-180, -120, 40, 30))
	spawn_region.append(Rect2(180, -120, -40, 30))
	spawn_region.append(Rect2(180, 120, -40, -30))
	spawn_region.append(Rect2(-180, 120, 40, -30))
	spawn_mob(MobVariables.Types.CULTIST)
	spawn_mob(MobVariables.Types.CULTIST)
	spawn_mob(MobVariables.Types.CULTIST)
	spawn_mob(MobVariables.Types.CULTIST)

func get_ready():
	var children := get_children()
	children[1].set_type(top)
	children[2].set_type(bottom)
	children[3].set_type(left)
	children[4].set_type(right)
	reward_spawn = Vector2(0, -72)

func _on_leaver_trigger():
	lit_count += 1
	if lit_count == light_count:
		complete()

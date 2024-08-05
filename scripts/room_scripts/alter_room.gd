extends Room

@export var left: int
@export var right: int
@export var top: int
@export var bottom: int

func turn_off_lights():
	get_child(8)._turn_off()
	get_child(9)._turn_off()
	get_child(10)._turn_off()
	get_child(11)._turn_off()
	get_child(12)._turn_off()
	get_child(13)._turn_off()
	get_child(14)._turn_off()
	get_child(15)._turn_off()

func set_spawn():
	spawn_region.append(Rect2(-180, -120, 40, 30))
	spawn_region.append(Rect2(180, -120, -40, 30))
	spawn_region.append(Rect2(180, 120, -40, -30))
	spawn_region.append(Rect2(-180, 120, 40, -30))
	spawn_mob(MobVariables.Types.CULTIST)
	spawn_mob(MobVariables.Types.CULTIST)
	spawn_mob(MobVariables.Types.CULTIST)
	spawn_mob(MobVariables.Types.CULTIST)
	spawn_mob(MobVariables.Types.MIST)
	spawn_mob(MobVariables.Types.MIST)

func get_ready():
	var children := get_children()
	children[1].set_type(0)
	children[2].set_type(bottom)
	children[3].set_type(left)
	children[4].set_type(right)
	reward_spawn = Vector2(0, 0)

func _on_alter_complete():
	complete()

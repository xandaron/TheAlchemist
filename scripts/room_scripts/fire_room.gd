extends Room

var time_to_survive := 15.0

@export var left: int
@export var right: int
@export var top: int
@export var bottom: int

func on_activation():
	get_child(5).start(time_to_survive)

func turn_off_lights():
	get_child(5).premiture_clear()
	get_child(5).turn_off_lights()

func set_spawn():
	spawn_region.append(Rect2(-144, -79, 64, 158))
	spawn_region.append(Rect2(144, -79, -64, 158))
	spawn_mob(MobVariables.Types.MIMIC)
	spawn_mob(MobVariables.Types.MIMIC)
	spawn_mob(MobVariables.Types.MIMIC)
	spawn_mob(MobVariables.Types.MIST)
	spawn_mob(MobVariables.Types.MIST)
	spawn_mob(MobVariables.Types.MIST)

func get_ready():
	var children := get_children()
	children[1].set_type(3)
	children[2].set_type(0)
	children[3].set_type(0)
	children[4].set_type(0)
	reward_spawn = Vector2(0, -72)

func _process(delta):
	if not activated or time_to_survive <= 0.0:
		return
	time_to_survive -= delta
	if time_to_survive <= 0.0:
		complete()

extends Room

var angle := 0.0

var time_correct_required := 2.0
var count_down: float = 0.0
var correct := false

func turn_off_lights():
	get_child(6)._turn_off()
	get_child(7)._turn_off()
	get_child(8)._turn_off()
	get_child(9)._turn_off()

func set_spawn():
	spawn_region.append(Rect2(-74, -113, 24, 221))
	spawn_region.append(Rect2(74, -113, -24, 221))
	spawn_mob(MobVariables.Types.CULTIST)
	spawn_mob(MobVariables.Types.CULTIST)
	spawn_mob(MobVariables.Types.CULTIST)
	spawn_mob(MobVariables.Types.CULTIST)

func get_ready():
	var children := get_children()
	children[1].set_type(0)
	children[2].set_type(0)
	children[3].set_type(4)
	children[4].set_type(4)
	angle = 90.0 * randi_range(1, 3)
	get_child(5).rotation_set(angle)
	reward_spawn = Vector2(0, 0)

func _process(delta):
	if not correct:
		return
	count_down -= delta
	if count_down <= 0.0:
		correct = false
		complete()

func _on_compass_rotate():
	angle += 90.0
	if angle == 360.0:
		count_down = time_correct_required
		angle = 0.0
		correct = true
		return
	correct = false

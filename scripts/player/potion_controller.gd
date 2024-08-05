extends Projectile

signal hit_targets(targets: Node2D, damage: float, elements: int)

const break_sound := preload("res://scenes/potion_break.tscn")

func pre_destroy():
	var temp := break_sound.instantiate()
	get_parent().add_child(temp)

func check_for_collision():
	if has_overlapping_bodies():
		hit_targets.emit(get_overlapping_bodies(), damage, elements)
		destroy()
		return

func _ready():
	fly_time = 1.0
	speed = PlayerVariables.throw_speed
	damage = PotionVariants.get_damage()
	elements = PotionVariants.get_element()
	PotionVariants.potion_changed.connect(_on_potion_updated)

func _on_potion_updated():
	var colour_child := get_child(3).get_child(0)
	var active_colour: Vector4 = PotionVariants.get_colour()
	colour_child.modulate.r8 = int(active_colour.x / active_colour.w)
	colour_child.modulate.g8 = int(active_colour.y / active_colour.w)
	colour_child.modulate.b8 = int(active_colour.z / active_colour.w)

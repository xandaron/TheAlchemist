extends Mob

const projectile := preload("res://scenes/mobs/shadow_flame.tscn")

func attack():
	var proj := projectile.instantiate()
	var target_position := PlayerVariables.position + \
		PlayerVariables.direction * PlayerVariables.speed * 0.5
	proj.initalize(position, (target_position - global_position).normalized())
	get_parent().add_child(proj)

func set_stats():
	health = MobVariables.mist_health
	speed = MobVariables.mist_speed
	attack_damage = MobVariables.mist_damage
	cooldown_time = MobVariables.mist_attack_cooldown
	element_resistant = MobVariables.mist_element_resistant
	element_vulnerable = MobVariables.mist_element_vulnerable
	type = MobVariables.Types.MIST
	distance_from_player = MobVariables.mist_distance_from_player
	get_child(2).get_child(0).scale = Vector2(MobVariables.cultist_range, MobVariables.cultist_range)

extends Mob

const projectile := preload("res://scenes/mobs/dagger.tscn")

func attack():
	var proj := projectile.instantiate()
	var target_position := PlayerVariables.position + \
		PlayerVariables.direction * PlayerVariables.speed * 0.5
	proj.initalize(position, (target_position - global_position).normalized())
	get_parent().add_child(proj)

func set_stats():
	health = MobVariables.cultist_health
	speed = MobVariables.cultist_speed
	attack_damage = MobVariables.cultist_damage
	cooldown_time = MobVariables.cultist_attack_cooldown
	element_resistant = MobVariables.cultist_element_resistant
	element_vulnerable = MobVariables.cultist_element_vulnerable
	type = MobVariables.Types.CULTIST
	distance_from_player = MobVariables.cultist_distance_from_player
	get_child(2).get_child(0).scale = Vector2(MobVariables.cultist_range, MobVariables.cultist_range)

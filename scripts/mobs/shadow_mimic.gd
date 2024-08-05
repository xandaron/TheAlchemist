extends Mob

const slash := preload("res://scenes/mobs/slash.tscn")

func attack():
	PlayerVariables.attack_player(attack_damage, MobVariables.mimic_damage_elements)
	var temp := slash.instantiate()
	get_parent().add_child(temp)
	temp.global_position = global_position
	if abs(direction.x) >= abs(direction.y):
		if direction.x < 0:
			temp.rotation_degrees = 90
			temp.global_position.x -= 10
		else:
			temp.rotation_degrees = 270
			temp.global_position.x += 10
	else:
		if direction.y < 0:
			temp.rotation_degrees = 180
			temp.global_position.y -= 10
		else:
			temp.rotation_degrees = 0
			temp.global_position.y += 10

func set_stats():
	health = MobVariables.mimic_health
	speed = MobVariables.mimic_speed
	attack_damage = MobVariables.mimic_damage
	cooldown_time = MobVariables.mimic_attack_cooldown
	element_resistant = MobVariables.mimic_element_resistant
	element_vulnerable = MobVariables.mimic_element_vulnerable
	type = MobVariables.Types.MIMIC
	distance_from_player = MobVariables.mimic_distance_from_player

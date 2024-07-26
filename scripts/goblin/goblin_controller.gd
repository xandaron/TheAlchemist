extends Mob

func _ready():
	id = 0
	health = GoblinVariables.health
	speed = GoblinVariables.speed
	attack_damage = GoblinVariables.damage
	death.connect($".."._on_mob_death)

func _physics_process(delta):
	if GlobalVariables.pause:
		return
	var distanceFromPlayer = PlayerVariables.position - position
	if distanceFromPlayer.length() > 100.0:
		var direction = distanceFromPlayer.normalized()
		var collision_info = move_and_collide(direction * GoblinVariables.speed * delta)
		while collision_info:
			var normal := collision_info.get_normal()
			collision_info = move_and_collide(Vector2(normal.y, -normal.x) * \
				collision_info.get_remainder().length() * direction.cross(normal))
	if cooldown_timer > 0.0:
		cooldown_timer -= delta
	elif within_attack_range:
		attack()
		cooldown_timer = GoblinVariables.attack_cooldown

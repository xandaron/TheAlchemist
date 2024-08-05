extends Projectile

func _ready():
	fly_time = MobVariables.cultist_projectile_lifetime
	speed = MobVariables.cultist_projectile_speed
	damage = MobVariables.cultist_damage
	elements = MobVariables.cultist_damage_elements

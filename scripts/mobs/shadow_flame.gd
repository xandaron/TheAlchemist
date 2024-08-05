extends Projectile

func _ready():
	fly_time = MobVariables.mist_projectile_lifetime
	speed = MobVariables.mist_projectile_speed
	damage = MobVariables.mist_damage
	elements = MobVariables.mist_damage_elements

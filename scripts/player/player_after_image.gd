extends Node2D

var life_time := 0.5

func _process(delta):
	modulate.a = life_time
	life_time -= delta
	if life_time <= 0.0:
		visible = false
		call_deferred("queue_free")

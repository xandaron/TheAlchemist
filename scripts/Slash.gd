extends AnimatedSprite2D

func _on_animation_finished():
	call_deferred("queue_free")

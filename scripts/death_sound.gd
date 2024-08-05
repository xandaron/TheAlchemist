extends AudioStreamPlayer2D

func _on_finished():
	call_deferred("queue_free")

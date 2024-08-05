extends Sprite2D

var lifetime := 2.0

func initalize(tex: Texture2D, pos: Vector2):
	texture = tex
	position = pos
	z_index = 10

func _process(delta):
	lifetime -= delta
	if lifetime < 0.0:
		visible = false
		call_deferred("queue_free")
		return

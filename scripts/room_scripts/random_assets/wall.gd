extends Sprite2D

func _ready():
	if randf() <= 0.2:
		texture = GlobalVariables.moss_wall

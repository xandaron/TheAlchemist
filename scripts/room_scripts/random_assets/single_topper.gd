extends Sprite2D

func _ready():
	texture = GlobalVariables.single_toppers.pick_random()

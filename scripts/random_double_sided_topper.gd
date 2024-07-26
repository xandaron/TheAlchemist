extends Sprite2D

func _ready():
	texture = GlobalVariables.double_sided_toppers.pick_random()

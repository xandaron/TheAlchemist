extends Sprite2D

var carpet: Array[Texture2D]

func _ready():
	carpet.append(preload("res://assets/textures/room_assets/decoration/carpet/red_carpet_edge.png"))
	carpet.append(preload("res://assets/textures/room_assets/decoration/carpet/purple_carpet_edge.png"))
	carpet.append(preload("res://assets/textures/room_assets/decoration/carpet/yellow_carpet_edge.png"))
	carpet.append(preload("res://assets/textures/room_assets/decoration/carpet/green_carpet_edge.png"))
	carpet.append(preload("res://assets/textures/room_assets/decoration/carpet/blue_carpet_edge.png"))

func set_type(index: int):
	texture = carpet[index]

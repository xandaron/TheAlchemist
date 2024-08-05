extends TextureRect

var containers: Array[Texture2D]

func _on_container_state_change(damage_level: int):
	texture = containers[damage_level]

func _ready():
	containers.append(preload("res://assets/textures/ui/health_damage_0.png"))
	containers.append(preload("res://assets/textures/ui/health_damage_1.png"))
	containers.append(preload("res://assets/textures/ui/health_damage_2.png"))
	containers.append(preload("res://assets/textures/ui/health_damage_3.png"))
	containers.append(preload("res://assets/textures/ui/health_damage_4.png"))
	containers.append(preload("res://assets/textures/ui/health_damage_broken.png"))
	PlayerVariables.container_state_change.connect(_on_container_state_change)

func _process(_delta):
	get_child(0).get_child(0).offset.y = \
		64 * -(PlayerVariables.health - PlayerVariables.max_health) / PlayerVariables.max_health

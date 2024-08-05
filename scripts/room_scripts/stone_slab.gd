extends Node2D

@export var type := 0

const red_statue := preload("res://assets/textures/room_assets/decoration/red_skull_statue.png")

var statue_collected := false
var interactable := false

func _ready():
	if type == 1:
		get_child(1).texture = red_statue

func _input(event):
	if event.is_action_pressed("interact") and interactable and not statue_collected:
		if PlayerVariables.encumbered:
			return
		if type == 0:
			PlayerVariables.pick_up(PlayerVariables.CarryItems.BLUE_STATUE)
		else:
			PlayerVariables.pick_up(PlayerVariables.CarryItems.RED_STATUE)
		statue_collected = true
		get_child(1).visible = false

func _on_pickup_area_entered(_body):
	interactable = true

func _on_pickup_area_exited(_body):
	interactable = false

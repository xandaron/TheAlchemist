extends Node2D

signal rotate

var interactable := false
var rotating := false
var time_to_rotate := 1.0
var rotation_timer := 0.0
var angle := 0.0

const sound := preload("res://scenes/grinding_stone.tscn")

func rotation_set(input: float):
	angle = input
	get_child(0).rotation_degrees = angle

func _input(event):
	if GlobalVariables.paused or GlobalVariables.in_menu:
		return
	if event.is_action_pressed("interact") and interactable and not rotating:
		add_child(sound.instantiate())
		rotate.emit()
		angle += 90.0
		rotating = true

func _process(delta):
	if not rotating:
		return
	rotation_timer -= delta
	if rotation_timer <= 0.0:
		get_child(0).rotation_degrees = angle
		rotating = false
		return
	get_child(0).rotation_degrees = angle

func _on_area_entered(_body):
	interactable = true

func _on_area_exited(_body):
	interactable = false

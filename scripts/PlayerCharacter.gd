extends CharacterBody2D

var speed = 300.0

func _physics_process(delta):
	var direction := Vector2(0.0, 0.0)	
	if Input.is_action_pressed("move up"):
		direction.y -= 1.0
	if Input.is_action_pressed("move down"):
		direction.y += 1.0
	if Input.is_action_pressed("move left"):
		direction.x -= 1.0
	if Input.is_action_pressed("move right"):
		direction.x += 1.0
	
	move_and_collide(direction * speed * delta)

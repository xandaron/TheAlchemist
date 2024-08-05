extends Sprite2D

var activated := false
var elapsed_time: float
var activate_time: float
var activated_count := 0
var number_of_children: int

func premiture_clear():
	activated = false

func turn_off_lights():
	for i in range(0, get_children().size()):
		if i % 4 == 0:
			get_child(i).get_child(0).queue_free()

func _ready():
	number_of_children = get_children().size()
	for child in get_children():
		child.play("default")
		child.visible = false

func start(time: float):
	activated = true
	activate_time = time / number_of_children

func _process(delta):
	if not activated or activated_count == number_of_children:
		return
	elapsed_time += delta
	var should_be_active: int = floor(elapsed_time / activate_time)
	while (activated_count < should_be_active):
		get_child(activated_count).visible = true
		if activated_count % 4 == 0:
			get_child(activated_count).get_child(0).enabled = true
		activated_count += 1

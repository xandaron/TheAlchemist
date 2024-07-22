extends PointLight2D

var timer := 0.0
var control := false

func _on_brazier_entered(_body):
	enabled = true
	control = true

func _process(delta):
	if not control:
		return
	
	if timer < 4:
		timer += delta
		energy = -(1 / pow(2.7182, timer - 1.8)) + 7
	else:
		energy = 7
		control = false
	

extends SpriteFade

signal close
signal open

func _on_room_activated():
	var children := get_children()
	children[0].play("close")
	children[1].visible = false
	children[2].visible = true
	children[3].collision_layer = 2

func _on_room_cleared():
	var children := get_children()
	children[0].play("open")
	children[1].visible = true
	children[2].visible = false
	children[3].collision_layer = 0

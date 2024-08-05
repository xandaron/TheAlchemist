extends TextureRect

func _ready():
	PotionVariants.potion_changed.connect(_on_potion_updated)

func _on_potion_updated():
	var children := get_children()
	children[0].texture = GlobalVariables.ingredient_icons[
		PotionVariants.get_modifier(PotionVariants.active_potion, 0)]
	children[2].texture = GlobalVariables.ingredient_icons[
		PotionVariants.get_modifier(PotionVariants.active_potion, 2)]
	children[1].texture = GlobalVariables.ingredient_icons[
		PotionVariants.get_modifier(PotionVariants.active_potion, 1)]
	
	var colour_child := children[3].get_child(0)
	var active_colour: Vector4 = PotionVariants.get_colour()
	colour_child.modulate.r8 = int(active_colour.x / active_colour.w)
	colour_child.modulate.g8 = int(active_colour.y / active_colour.w)
	colour_child.modulate.b8 = int(active_colour.z / active_colour.w)

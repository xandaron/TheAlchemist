extends Control

var potion: int
var slot: int

func _ready():
	GlobalVariables.unlock.connect(_on_unlock_ingredient)
	var ingredients_table := get_child(3)
	for i in range(0, GlobalVariables.ingredient_names.size()):
		ingredients_table.add_icon_item(GlobalVariables.ingredient_icons[i])
		ingredients_table.set_item_tooltip(i, GlobalVariables.ingredient_names[i] + 
			" - " + GlobalVariables.ingredient_descriptions[i])
		ingredients_table.set_item_tooltip_enabled(i, true)
		ingredients_table.set_item_disabled(i, true)
	ingredients_table.set_item_disabled(0, false)

func toggle():
	visible = not visible
	if visible:
		pass

func _on_unlock_ingredient(index: int):
	get_child(3).set_item_disabled(index, false)

func _on_potion_selected(index: int):
	potion = index
	for i in range(0, 3):
		get_child(2).set_item_icon(
			i, GlobalVariables.ingredient_icons[PotionVariants.get_modifier(potion, i)])
	get_child(3).select(PotionVariants.get_modifier(potion, slot))

func _on_slot_selected(index: int):
	slot = index
	get_child(3).select(PotionVariants.get_modifier(potion, slot))

func _on_ingredient_selected(index: int):
	PotionVariants.set_modifier(potion, slot, index)
	get_child(2).set_item_icon(slot, GlobalVariables.ingredient_icons[index])

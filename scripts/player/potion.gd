extends Node

signal potion_changed

var potion_count := 3

const BASE_DAMAGE := 30.0
var damage: Array[float]
var element: Array[int]
var colour: Array[Vector4]
var modifiers: Array[int]
var max_modifiers := 3

var active_potion := 0

func calculate_modifier(potion_id: int):
	colour[potion_id] = Vector4(0, 0, 0, 0)
	for index in range(potion_id * 3, potion_id * 3 + max_modifiers):
		var mod: Vector3 = GlobalVariables.ingredient_effects[modifiers[index]]
		var ingredient_colour: Vector4 = GlobalVariables.ingredient_colours[modifiers[index]]
		colour[potion_id] += Vector4(
			ingredient_colour.x, ingredient_colour.y, ingredient_colour.z, 1) * ingredient_colour.w
		if int(mod.x) == GlobalVariables.Potion_Modifiers.NONE:
			continue
		if int(mod.x) == GlobalVariables.Potion_Modifiers.DAMAGE:
			if int(mod.y) == GlobalVariables.Stat_Modifier_Types.FLAT:
				damage[potion_id] += mod.z
			elif int(mod.y) == GlobalVariables.Stat_Modifier_Types.SCALE:
				damage[potion_id] *= mod.z
		elif int(mod.x) == GlobalVariables.Potion_Modifiers.ELEMENTAL:
			element[potion_id] |= int(mod.y)

func set_modifier(potion_id: int, slot: int, mod_index: int):
	modifiers[slot + potion_id * max_modifiers] = mod_index
	calculate_modifier(potion_id)
	potion_changed.emit()

func get_modifier(potion_id: int, slot: int):
	return modifiers[slot + potion_id * max_modifiers]

func get_damage():
	return damage[active_potion]

func get_element():
	return element[active_potion]

func get_colour():
	return colour[active_potion]

func _ready():
	element.resize(potion_count)
	colour.resize(potion_count)
	modifiers.resize(potion_count * max_modifiers)
	for i in range(0, potion_count):
		damage.append(BASE_DAMAGE)
		calculate_modifier(i)

func _input(event):
	if event.is_action_pressed("potion_0"):
		active_potion = 0
	elif event.is_action_pressed("potion_1"):
		active_potion = 1
	elif event.is_action_pressed("potion_2"):
		active_potion = 2
	potion_changed.emit()

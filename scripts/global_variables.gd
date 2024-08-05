extends Node

signal unlock(int)

var paused := false
var in_menu := false

var reward_sprite := preload("res://scenes/reward_sprite.tscn")

var double_sided_toppers: Array[Texture2D]
var double_toppers: Array[Texture2D]
var short_double_topper: Array[Texture2D]
var single_toppers: Array[Texture2D]
var short_single_topper: Array[Texture2D]
var corner_topper: Array[Texture2D]
var spikes: Array[Texture2D]

var moss_wall := preload("res://assets/textures/room_assets/walls/moss.png")

enum Potion_Modifiers {NONE, DAMAGE, ELEMENTAL}
enum Stat_Modifier_Types {FLAT, SCALE}
enum Elements {NONE, FIRE, WATER, ELECTRICITY, EARTH, HOLY, DARK, WIND, MAGIC}

var ingredient_names: Array[String]
var ingredient_icons: Array[Texture2D]
var ingredient_descriptions: Array[String]
# x = modifiers
# y = stat_modifier_type or element
# z = stat modify amount
var ingredient_effects: Array[Vector3]
var ingredient_colours: Dictionary
var not_collected_ingredients: Array[int]

func gen_ingredients():
	ingredient_names.append("None")
	ingredient_icons.append(preload("res://assets/textures/item_icons/nil.png"))
	ingredient_descriptions.append("You got no ingredients?")
	ingredient_effects.append(Vector3(0, 0, 0))
	ingredient_colours[0] = Vector4(50, 150, 255, 0.3)
	
	ingredient_names.append("Poop")
	ingredient_icons.append(preload("res://assets/textures/item_icons/poop.png"))
	ingredient_descriptions.append("Deals emotional damage!")
	ingredient_effects.append(Vector3(Potion_Modifiers.DAMAGE, Stat_Modifier_Types.FLAT, 10))
	ingredient_colours[1] = Vector4(179, 89, 0, 0.5)
	
	ingredient_names.append("Poison Vile")
	ingredient_icons.append(preload("res://assets/textures/item_icons/poison_vile.png"))
	ingredient_descriptions.append("You know what poison is right?")
	ingredient_effects.append(Vector3(Potion_Modifiers.DAMAGE, Stat_Modifier_Types.SCALE, 1.5))
	ingredient_colours[2] = Vector4(128, 255, 0, 0.2)
	
	ingredient_names.append("Star Dust")
	ingredient_icons.append(preload("res://assets/textures/item_icons/star_dust.png"))
	ingredient_descriptions.append("Twinkle twinkle little star... WIP")
	ingredient_effects.append(Vector3(Potion_Modifiers.ELEMENTAL, Elements.HOLY, 0))
	ingredient_colours[3] = Vector4(255, 255, 204, 0.4)
	
	ingredient_names.append("Fire Essence")
	ingredient_icons.append(preload("res://assets/textures/item_icons/fire_essence.png"))
	ingredient_descriptions.append("Kinda warm I guess? WIP")
	ingredient_effects.append(Vector3(Potion_Modifiers.ELEMENTAL, Elements.FIRE, 0))
	ingredient_colours[4] = Vector4(255, 51, 51, 1)
	
	ingredient_names.append("Water Essence")
	ingredient_icons.append(preload("res://assets/textures/item_icons/water_essence.png"))
	ingredient_descriptions.append("Hold on that's clearly a bubble not water! WIP")
	ingredient_effects.append(Vector3(Potion_Modifiers.ELEMENTAL, Elements.WATER, 0))
	ingredient_colours[5] = Vector4(51, 204, 255, 1)
	
	ingredient_names.append("Bone of a Litch")
	ingredient_icons.append(preload("res://assets/textures/item_icons/liches_bone.png"))
	ingredient_descriptions.append("This description is humerus. WIP")
	ingredient_effects.append(Vector3(Potion_Modifiers.ELEMENTAL, Elements.MAGIC, 0))
	ingredient_colours[6] = Vector4(242, 242, 242, 0.6)
	
	ingredient_names.append("Salt")
	ingredient_icons.append(preload("res://assets/textures/item_icons/salt.png"))
	ingredient_descriptions.append("Why you salty bro?")
	ingredient_effects.append(Vector3(Potion_Modifiers.DAMAGE, Stat_Modifier_Types.FLAT, 20))
	ingredient_colours[7] = Vector4(255, 255, 255, 0.2)
	
	ingredient_names.append("Special Shroom")
	ingredient_icons.append(preload("res://assets/textures/item_icons/special_shroom.png"))
	ingredient_descriptions.append("{Insert Thor mushroom fact here}")
	ingredient_effects.append(Vector3(Potion_Modifiers.DAMAGE, Stat_Modifier_Types.SCALE, 2))
	ingredient_colours[8] = Vector4(204, 68, 0, 0.35)
	
	for i in range(1, ingredient_names.size()):
		not_collected_ingredients.append(i)

func give_player_random_reward(pos: Vector2):
	if not_collected_ingredients.size() == 0:
		return
	var reward: int = not_collected_ingredients.pick_random()
	not_collected_ingredients.remove_at(not_collected_ingredients.find(reward))
	unlock.emit(reward)
	var sprite := reward_sprite.instantiate()
	pos.y -= 20
	sprite.initalize(ingredient_icons[reward], pos)
	get_tree().root.get_child(0).add_child(sprite)

func _ready():
	for i in range(0, 6):
		double_toppers.append(
			load("res://assets/textures/room_assets/wall_toppers/double/double_0" \
				+ str(i) + ".png"))
		double_sided_toppers.append(
			load("res://assets/textures/room_assets/wall_toppers/double_sided/double_sided_0" \
				+ str(i) + ".png"))
		short_single_topper.append(
			load("res://assets/textures/room_assets/wall_toppers/short_single/short_single_0" \
				+ str(i) + ".png"))
	for i in range(0, 4):
		short_double_topper.append(
			load("res://assets/textures/room_assets/wall_toppers/short_double/short_double_0" \
				+ str(i) + ".png"))
	for i in range(0, 2):
		corner_topper.append(
			load("res://assets/textures/room_assets/wall_toppers/corner/corner_0" \
				+ str(i) + ".png"))
	for i in range(0, 10):
		single_toppers.append(
			load("res://assets/textures/room_assets/wall_toppers/single/single_0" \
				+ str(i) + ".png"))
	for i in range(0, 3):
		spikes.append(
			load("res://assets/textures/room_assets/floors/spikes_" + str(i) + ".png"))
	gen_ingredients()

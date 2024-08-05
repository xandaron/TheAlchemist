extends Node

enum Types {MIMIC, MIST, CULTIST}

const mimic := preload("res://scenes/mobs/shadow_mimic.tscn")

const MIMIC_BASE_HEALTH := 100.0
var mimic_health := MIMIC_BASE_HEALTH

const MIMIC_BASE_SPEED := 65.0
var mimic_speed := MIMIC_BASE_SPEED

const MIMIC_BASE_ATTACK_DELAY := 0.6
var mimic_attack_cooldown := MIMIC_BASE_ATTACK_DELAY

const MIMIC_BASE_DAMAGE := 1
var mimic_damage := MIMIC_BASE_DAMAGE

const MIMIC_BASE_DISTANCE_FROM_PLAYER := 20.0
var mimic_distance_from_player := MIMIC_BASE_DISTANCE_FROM_PLAYER

const MIMIC_BASE_DAMAGE_ELEMENTS := GlobalVariables.Elements.DARK
var mimic_damage_elements := MIMIC_BASE_DAMAGE_ELEMENTS

const MIMIC_BASE_ELEMENT_VULNERABLE := GlobalVariables.Elements.HOLY
var mimic_element_vulnerable := MIMIC_BASE_ELEMENT_VULNERABLE

const MIMIC_BASE_ELEMENT_RESISTANT := GlobalVariables.Elements.DARK
var mimic_element_resistant := MIMIC_BASE_ELEMENT_RESISTANT



const mist := preload("res://scenes/mobs/shadow_mist.tscn")

const MIST_BASE_HEALTH := 100.0
var mist_health := MIST_BASE_HEALTH

const MIST_BASE_SPEED := 50.0
var mist_speed := MIST_BASE_SPEED

const MIST_BASE_ATTACK_DELAY := 0.8
var mist_attack_cooldown := MIST_BASE_ATTACK_DELAY

const MIST_BASE_DAMAGE := 1
var mist_damage := MIST_BASE_DAMAGE

const MIST_BASE_DAMAGE_ELEMENTS := GlobalVariables.Elements.DARK
var mist_damage_elements := MIST_BASE_DAMAGE_ELEMENTS

const MIST_BASE_PROJECTILE_SPEED := 80.0
var mist_projectile_speed := MIST_BASE_PROJECTILE_SPEED

const MIST_BASE_DISTANCE_FROM_PLAYER := 55.0
var mist_distance_from_player := MIST_BASE_DISTANCE_FROM_PLAYER

const MIST_BASE_PROJECTILE_LIFETIME := 1.5
var mist_projectile_lifetime := MIST_BASE_PROJECTILE_LIFETIME

const MIST_BASE_RANGE := 8
var mist_range := MIST_BASE_RANGE

const MIST_BASE_ELEMENT_VULNERABLE := GlobalVariables.Elements.HOLY
var mist_element_vulnerable := MIST_BASE_ELEMENT_VULNERABLE

const MIST_BASE_ELEMENT_RESISTANT := GlobalVariables.Elements.DARK
var mist_element_resistant := MIST_BASE_ELEMENT_RESISTANT



const cultist := preload("res://scenes/mobs/cultist.tscn")

const CULTIST_BASE_HEALTH := 100.0
var cultist_health := CULTIST_BASE_HEALTH

const CULTIST_BASE_SPEED := 50.0
var cultist_speed := CULTIST_BASE_SPEED

const CULTIST_BASE_ATTACK_DELAY := 0.8
var cultist_attack_cooldown := CULTIST_BASE_ATTACK_DELAY

const CULTIST_BASE_DAMAGE := 1
var cultist_damage := CULTIST_BASE_DAMAGE

const CULTIST_BASE_DAMAGE_ELEMENTS := GlobalVariables.Elements.DARK
var cultist_damage_elements := CULTIST_BASE_DAMAGE_ELEMENTS

const CULTIST_BASE_PROJECTILE_SPEED := 80.0
var cultist_projectile_speed := CULTIST_BASE_PROJECTILE_SPEED

const CULTIST_BASE_DISTANCE_FROM_PLAYER := 55.0
var cultist_distance_from_player := CULTIST_BASE_DISTANCE_FROM_PLAYER

const CULTIST_BASE_PROJECTILE_LIFETIME := 1.5
var cultist_projectile_lifetime := CULTIST_BASE_PROJECTILE_LIFETIME

const CULTIST_BASE_RANGE := 8
var cultist_range := CULTIST_BASE_RANGE

const CULTIST_BASE_ELEMENT_VULNERABLE := GlobalVariables.Elements.HOLY
var cultist_element_vulnerable := CULTIST_BASE_ELEMENT_VULNERABLE

const CULTIST_BASE_ELEMENT_RESISTANT := GlobalVariables.Elements.DARK
var cultist_element_resistant := CULTIST_BASE_ELEMENT_RESISTANT

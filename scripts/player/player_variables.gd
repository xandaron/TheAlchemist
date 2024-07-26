extends Node

var position := Vector2(0.0, 0.0)

const BASE_HEALTH := 100.0
var health := BASE_HEALTH

const BASE_SPEED := 300.0
var speed := BASE_SPEED

const BASE_COOLDOWN := 0.5
var cooldown := BASE_COOLDOWN
var cooldown_timer := 0.0

const BASE_IMMUNITY_TIME := 1.0
var immunity_time := BASE_IMMUNITY_TIME
var immunity_timer := 0.0

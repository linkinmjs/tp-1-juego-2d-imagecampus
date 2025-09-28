extends Node

signal sea_revealed
signal evade_island
signal player_hitted
signal clouds_over_the_ship
signal dispersed_clouds
signal on_cannon_ball_shotted

signal update_ammo
signal update_health
signal update_score

var life: int = 3
var collected_coins: int = 0
var collected_cannon_balls: int = 10

# Parrot on pirate
var parrot_on_pirate_cannon = false
var parrot_on_pirate_lookout = false
var parrot_on_captain = false
var parrot_on_pirate_fisherman = false

# Clouds and island on ship (used for top_scene)
var ship_colliding_clouds: bool = false
var ship_colliding_island: bool = false

var treasure_limit: int = 3
var island_limit: int = 2
var current_treasures: int = 0
var current_islands: int = 0

const COLLECTIBLES_TYPES = ["coin", "cannon_ball", "star"]
const AVAILABLE_TYPES = [COLLECTIBLES_TYPES[0], COLLECTIBLES_TYPES[1]]
const PIRATES_TYPES = ["captain", "pirate_cannon", "pirate_lookout", "pirate_fisherman"]

func _ready() -> void:
	pass

func get_collectible(type: String, amount: int):
	# Coin
	if type == COLLECTIBLES_TYPES[0]:
		collected_coins += amount
		emit_signal("update_score")
	#Cannon Ball
	elif type == COLLECTIBLES_TYPES[1]:
		collected_cannon_balls += amount
		emit_signal("update_ammo")

func get_damage(damage: int):
	life -= damage
	emit_signal("update_health")

func waste_ammo(ammo: int):
	collected_cannon_balls -= ammo
	emit_signal("update_ammo")
	emit_signal("on_cannon_ball_shotted")

func reveal_sea() -> void:
	emit_signal("sea_revealed")

func evade() -> void:
	emit_signal("evade_island")

func clouds_cover_ship(is_cover: bool) -> void:
	if is_cover:
		emit_signal("clouds_over_the_ship")
	elif not is_cover:
		emit_signal("dispersed_clouds")

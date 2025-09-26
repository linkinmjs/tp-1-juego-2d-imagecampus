extends Node

signal sea_revealed
signal player_hitted
signal clouds_over_the_ship
signal dispersed_clouds
signal cannon_ball_shotted

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

const COLLECTIBLES_TYPES = ["coin", "cannon_ball", "star"]
const PIRATES_TYPES = ["captain", "pirate_cannon", "pirate_lookout", "pirate_fisherman"]

func _ready() -> void:
	pass

func get_collectible(type: String, amount: int):
	# Coin
	if type == COLLECTIBLES_TYPES[0]:
		collected_coins += amount
	#Cannon Ball
	elif type == COLLECTIBLES_TYPES[1]:
		collected_cannon_balls += amount

func get_damage(damage: int):
	life -= damage
	
func reveal_sea() -> void:
	emit_signal("sea_revealed")
	
func clouds_cover_ship(is_cover: bool) -> void:
	if is_cover:
		emit_signal("clouds_over_the_ship")
	elif not is_cover:
		print("dispersed_clouds!")
		emit_signal("dispersed_clouds")

func on_cannon_ball_shotted() -> void:
	emit_signal("cannon_ball_shotted")

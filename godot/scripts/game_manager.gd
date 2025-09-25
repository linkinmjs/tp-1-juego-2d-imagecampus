extends Node

signal sea_revealed
signal player_hitted

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

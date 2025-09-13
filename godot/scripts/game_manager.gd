extends Node

var life: int = 3
var collected_coins: int = 0
var collected_cannon_balls: int = 10

# Parrot on pirate
var parrot_on_pirate_cannon = false
var parrot_on_pirate_lookout = false
var parrot_on_captain = false

const COIN: String = "coin"
const CANNON_BALL: String = "cannon_ball"
const STAR: String = "star"

func get_collectible(type: String, amount: int):
	if type == COIN:
		collected_coins += collected_coins + amount
	elif type == CANNON_BALL:
		collected_cannon_balls += collected_cannon_balls + amount

func get_damage(damage: int):
	print("recibe daño!")
	life = life - damage

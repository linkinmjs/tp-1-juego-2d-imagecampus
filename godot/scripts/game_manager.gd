extends Node

var coins: int = 0
var cannon_balls: int = 0
var life: int = 3

func add_coin():
	coins += 1
	print("total coins: ", coins)
	
func add_cannon_ball():
	cannon_balls += 1

func get_damage(damage: int):
	print("recibe daño!")
	life = life - damage

class_name Collectible
extends RigidBody2D

const COIN = GameManager.COLLECTIBLES_TYPES[0]
const CANNON_BALL = GameManager.COLLECTIBLES_TYPES[1]
const STAR = GameManager.COLLECTIBLES_TYPES[2]

@export_enum(COIN, CANNON_BALL) var collectible_type: String
@export var amount: int = 1

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if collectible_type == COIN:
		animated_sprite_2d.play("idle_coin")
	elif collectible_type == CANNON_BALL:
		animated_sprite_2d.play("idle_cannon_ball")
	elif collectible_type == STAR:
		animated_sprite_2d.play("idle_star")

func _process(_delta: float) -> void:
	if sleeping and not animation_player.is_playing():
		animation_player.play("idle")

func _on_area_2d_body_entered(_body: Node2D) -> void:
	GameManager.get_collectible(collectible_type, amount)
	queue_free()

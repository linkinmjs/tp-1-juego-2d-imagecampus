extends RigidBody2D

@export_enum("coin", "cannon_ball", "star") var collectible_type: String
@export var amount: int = 1
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_area_2d_body_entered(body: Node2D) -> void:
	GameManager.get_collectible(collectible_type, amount)
	queue_free()

func _ready() -> void:
	if collectible_type == "coin":
		animated_sprite_2d.play("idle_coin")
	elif collectible_type == "cannon_ball":
		animated_sprite_2d.play("idle_cannon_ball")
	elif collectible_type == "star":
		animated_sprite_2d.play("idle_star")

func _process(delta: float) -> void:
	
	if sleeping and not animation_player.is_playing():
		print("animation playing")
		animation_player.play("idle")

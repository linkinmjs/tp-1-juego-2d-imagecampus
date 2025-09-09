extends RigidBody2D

@export_enum("Coin", "Cannon", "Star") var collectible_type: String = "Coin"

func _on_area_2d_body_entered(body: Node2D) -> void:
	GameManager.add_coin()
	queue_free()

class_name Bird
extends AnimatedSprite2D

@export var speed: int = 200

func _process(delta: float) -> void:
	global_position.x = global_position.x + (speed * delta)
	if speed <= 0:
		scale.x = -abs(scale.x)

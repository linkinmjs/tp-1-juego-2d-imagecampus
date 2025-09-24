extends AnimatedSprite2D

var mouse_position: Vector2
var is_looking_left: bool = true

func _process(delta: float) -> void:
	mouse_position = get_global_mouse_position()

	if mouse_position < global_position and not is_looking_left:
		turn_left_animation()
	if mouse_position > global_position and is_looking_left:
		turn_right_animation()

func turn_left_animation() -> void:
	is_looking_left = true
	play("turn_left")
	await animation_finished
	play("idle_left")

func turn_right_animation() -> void:
	is_looking_left = false
	play("turn_right")
	await animation_finished
	play("idle_right")

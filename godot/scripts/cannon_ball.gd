extends RigidBody2D

# Slides used for test
#@export_range(400, 1200, 100, "x_min", "x_max") var impulse_x: float = 50
#@export_range(-1000, 0.0, 100, "y_min", "y_max") var impulse_y: float = 50

@onready var rand_impulse_x: float
@onready var rand_impulse_y: float

func _ready() -> void:
	rand_impulse_x = randf_range(900, 1200)
	rand_impulse_y = randf_range(-400,-300)
	var impulse: Vector2 = Vector2(rand_impulse_x, rand_impulse_y)
	apply_impulse(impulse)

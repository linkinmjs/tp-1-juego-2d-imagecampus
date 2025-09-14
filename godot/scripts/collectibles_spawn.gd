extends Area2D

@export var collectible_scene: PackedScene
@onready var spawn_timer: Timer = $SpawnTimer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	spawn_timer.connect("timeout", _on_spawn_timer_timeout)

func _on_spawn_timer_timeout() -> void:
	spawn_collectible()
	spawn_timer.start()
	pass

func spawn_collectible() -> void:
	var collectible: RigidBody2D = collectible_scene.instantiate()
	collectible.global_position = get_random_position_in_shape()
	add_child(collectible)

func random_point_in_ellipse(rx: float, ry: float) -> Vector2:
	var angle = randf_range(0.0, TAU) # TAU = 2*PI
	var r = sqrt(randf())             # sqrt para distribución uniforme
	var x = r * cos(angle) * rx
	var y = r * sin(angle) * ry
	return Vector2(x, y)
	
func get_random_position_in_shape() -> Vector2:
	var circle_shape: CircleShape2D = $CollisionShape2D.shape
	var radius = circle_shape.radius
	
	# El óvalo se genera escalando el círculo
	var rx = radius * $CollisionShape2D.scale.x
	var ry = radius * $CollisionShape2D.scale.y
	
	var local_point = random_point_in_ellipse(rx, ry)
	return $CollisionShape2D.global_position + local_point

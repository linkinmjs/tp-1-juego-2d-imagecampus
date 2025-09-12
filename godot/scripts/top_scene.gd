extends Node2D

@onready var cannon_position: Marker2D = $Ship/CannonPosition
@onready var cannon_ball_scene = preload("res://scenes/cannon_ball.tscn")

func _process(delta: float) -> void:
	# TODO replace next hardcode
	if Input.is_action_just_pressed("action"):
		shoot()

func shoot() -> void:
	var cannon_ball: RigidBody2D = cannon_ball_scene.instantiate()
	cannon_ball.global_position = cannon_position.global_position
	add_child(cannon_ball)

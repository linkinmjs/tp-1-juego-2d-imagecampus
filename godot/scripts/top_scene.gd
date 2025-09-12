extends Node2D

@onready var cannon_position: Marker2D = $Ship/CannonPosition
@onready var cannon_ball_scene = preload("res://scenes/cannon_ball.tscn")
@onready var shoot_delay: Timer = $ShootDelay

func _process(delta: float) -> void:
	# TODO replace next hardcode
	if Input.is_action_just_pressed("action") and GameManager.parrot_on_pirate_cannon:
		shoot()

func shoot() -> void:
	shoot_delay.start()
	await shoot_delay.timeout
	var cannon_ball: RigidBody2D = cannon_ball_scene.instantiate()
	cannon_ball.global_position = cannon_position.global_position
	add_child(cannon_ball)

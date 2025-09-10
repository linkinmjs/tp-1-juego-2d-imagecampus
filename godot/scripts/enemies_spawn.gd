class_name EnemiesSpawn
extends Area2D

@export_group("Horde Properties")
@export_range(0, 100, 2) var quantity: int = 10
@export var min_speed: int = 200
@export var max_speed: int = 400
@export var enemy_scene: PackedScene = preload("res://scenes/bird.tscn")

var spawn_sides: Array = ["left", "right"]

var top_limit_spawn: int = 580
var down_limit_spawn: int = 1000
var left_limit_spawn: int = -abs(10)
var right_limit_spawn: int = abs(2900)

@onready var spawn_single_enemy_timer: Timer = $SpawnSingleEnemyTimer
@onready var wave_interval_timer: Timer = $WaveIntervalTimer


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if wave_interval_timer.is_stopped():
		wave_interval_timer.start()
		await wave_interval_timer.timeout
		spawn_enemies()

func spawn_enemies():
	print("spawn!")
	var spawn_side = spawn_sides.pick_random()
	for i in range(quantity):
		spawn_single_enemy_timer.start()
		await spawn_single_enemy_timer.timeout
		var enemy: Bird = enemy_scene.instantiate()
		enemy.speed = randi_range(min_speed, max_speed)
		enemy.global_position.y = randi_range(top_limit_spawn, down_limit_spawn)
		if spawn_side == "left":
			enemy.global_position.x = left_limit_spawn
			enemy.speed = abs(enemy.speed)
		elif spawn_side == "right":
			enemy.position.x = right_limit_spawn
			enemy.speed = -abs(enemy.speed)
		add_child(enemy)

func modify_spawn(min_s: int, max_s: int, q: int):
	min_speed = min_s
	max_speed = max_s
	quantity = q
	

func _on_area_exited(area: Area2D) -> void:
	area.get_parent().queue_free()

extends Area2D

@export_group("Horde Properties")
@export_range(0, 100, 2) var quantity: int = 10
@export var min_speed: int = 200
@export var max_speed: int = 400
@export_enum("left", "right") var spawn_side: String = "left"
@export var enemy_scene: PackedScene = preload("res://scenes/bird.tscn")

var top_limit_spawn: int = 580
var down_limit_spawn: int = 1000
var left_limit_spawn: int = -abs(10)
var right_limit_spawn: int = abs(2900)

@onready var spawn_timer: Timer = $SpawnTimer


func _ready() -> void:
	spawn_enemies()

func spawn_enemies():
	for i in range(quantity):
		print("spawn!")
		spawn_timer.start()
		await spawn_timer.timeout
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

func _on_area_exited(area: Area2D) -> void:
	print("Se fueron del área")
	area.get_parent().queue_free()

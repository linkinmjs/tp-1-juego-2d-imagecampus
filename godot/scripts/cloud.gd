extends PathFollow2D

@export_range(1, 200, 1) var speed: float = 50
@onready var cloud_hitbox: Area2D = $CloudHitbox
@export var obstacle_scene: PackedScene = preload("res://scenes/island.tscn")

func _ready() -> void:
	cloud_hitbox.body_entered.connect(_on_cloud_hitbox_body_entered)

func _process(delta: float) -> void:
	progress += speed * delta
	if progress_ratio >= 1.0:
		queue_free()

func _on_cloud_hitbox_body_entered(_area):
	var obstacle: PathFollow2D =obstacle_scene.instantiate()
	add_sibling(obstacle)
	obstacle.global_position = position
	queue_free()

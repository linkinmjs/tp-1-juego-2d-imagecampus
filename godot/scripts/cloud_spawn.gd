extends Path2D

@onready var spawn_timer: Timer = $SpawnTimer
@export var clouds_scenes_to_spawn: Array[PackedScene]

func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)

func _on_spawn_timer_timeout() -> void:
	var selected_scene_packed: PackedScene = clouds_scenes_to_spawn.pick_random()
	var cloud_scene: PathFollow2D = selected_scene_packed.instantiate()
	add_child(cloud_scene)

extends Path2D

@onready var spawn_timer: Timer = $SpawnTimer
@export var clouds_scenes_to_spawn: Array[PackedScene]
@export var timer_wait_time: float = 0.8
@export_enum("Top", "Bottom") var spawn_on_scene: String

var is_active = true

func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.wait_time = timer_wait_time

#TODO: improve next code. Convert this _process to signals
func _process(delta: float) -> void:
	if not is_active:
		spawn_timer.paused = true
	elif is_active:
		spawn_timer.paused = false

func _on_spawn_timer_timeout() -> void:
	var selected_scene_packed: PackedScene = clouds_scenes_to_spawn.pick_random()
	var cloud_scene: PathFollow2D = selected_scene_packed.instantiate()
	add_child(cloud_scene)

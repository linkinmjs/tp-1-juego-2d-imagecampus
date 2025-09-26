extends Path2D

@export var clouds_scenes_to_spawn: Array[PackedScene]
@export var timer_wait_time: float = 0.8
@export var is_active = true
@export_enum("Top", "Bottom") var spawn_on_scene: String

@onready var spawn_timer: Timer = $SpawnTimer

func _ready() -> void:
	GameManager.clouds_over_the_ship.connect(_on_clouds_over_the_ship)
	GameManager.dispersed_clouds.connect(_on_clouds_leave_the_ship)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.wait_time = timer_wait_time

#TODO: improve next code. Convert this _process to signals
func _process(_delta: float) -> void:
	if spawn_on_scene == "Bottom":
		if not is_active:
			spawn_timer.paused = true
		elif is_active:
			spawn_timer.paused = false

func _on_spawn_timer_timeout() -> void:
	var selected_scene_packed: PackedScene = clouds_scenes_to_spawn.pick_random()
	var cloud_scene: PathFollow2D = selected_scene_packed.instantiate()
	add_child(cloud_scene)

func _on_clouds_over_the_ship() -> void:
	if spawn_on_scene == "Bottom":
		is_active = true
	
func _on_clouds_leave_the_ship() -> void:
	if spawn_on_scene == "Bottom":
		is_active = false

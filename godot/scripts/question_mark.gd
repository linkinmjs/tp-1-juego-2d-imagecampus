class_name QuestionMark
extends PathFollow2D

@export_range(1, 200, 1) var speed: float = 50
@export var events: Array[PackedScene]

func _process(delta: float) -> void:
	progress += speed * delta
	if progress_ratio >= 1.0:
		queue_free()

func reveal_random_event() -> void:
	var random_event_scene: PackedScene = events.pick_random()
	var event_scene: PathFollow2D = random_event_scene.instatiate()
	add_sibling(event_scene)
	event_scene.progress_ratio = progress_ratio
	queue_free()
	

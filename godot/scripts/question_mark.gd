class_name QuestionMark
extends PathFollow2D

@export_range(1, 200, 1) var speed: float = 50
@export var events: Array[PackedScene]

func _ready() -> void:
	GameManager.sea_revealed.connect(_on_sea_revealed)

func _process(delta: float) -> void:
	progress += speed * delta
	if progress_ratio >= 1.0:
		queue_free()

func _on_sea_revealed() -> void:
	reveal_random_event()

func reveal_random_event() -> void:
	var selected_scene_packed: PackedScene = events.pick_random()
	var event_scene: PathFollow2D = selected_scene_packed.instantiate()
	if exceeds_the_limit(event_scene.name):
		queue_free()
	add_sibling(event_scene)
	event_scene.progress_ratio = progress_ratio
	queue_free()

## TODO: must continue from here (and fix)
func exceeds_the_limit(name: String) -> bool:
	if name == "Island":
		if GameManager.current_islands > GameManager.island_limit:
			return true
	if name == "Treasure":
		if GameManager.current_treasures > GameManager.treasure_limit:
			return true
	return false

extends PathFollow2D

@export_range(1, 200, 1) var speed: float = 50

func _ready() -> void:
	GameManager.current_treasures += 1

func _process(delta: float) -> void:
	progress += speed * delta
	if progress_ratio >= 1.0:
		GameManager.current_treasures -= 1
		queue_free()

extends PathFollow2D

@export_range(1, 200, 1) var speed: float = 50

func _process(delta: float) -> void:
	progress += speed * delta
	if progress_ratio >= 1.0:
		queue_free()

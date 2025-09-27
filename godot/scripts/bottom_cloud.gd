extends PathFollow2D

@export_range(1, 200, 1) var speed: float = 50

func _ready() -> void:
	GameManager.dispersed_clouds.connect(_on_cloud_dispersed)

func _process(delta: float) -> void:
	progress += speed * delta
	if progress_ratio >= 1.0:
		queue_free()

func _on_cloud_dispersed() -> void:
	# TODO: Some animation here
	queue_free()

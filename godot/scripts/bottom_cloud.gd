extends PathFollow2D

@export_range(1, 200, 1) var speed: float = 50
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	GameManager.dispersed_clouds.connect(_on_cloud_dispersed)

func _process(delta: float) -> void:
	progress += speed * delta
	if progress_ratio >= 1.0:
		queue_free()

func _on_cloud_dispersed() -> void:
	animation_player.play("dissapear")
	await animation_player.animation_finished
	queue_free()

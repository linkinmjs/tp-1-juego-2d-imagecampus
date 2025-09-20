extends PathFollow2D

@export_range(1, 200, 1) var speed: float = 50
@export var spawn_probability: float = 0.9 # default 0.05
@onready var cloud_hitbox: Area2D = $CloudHitbox
const QUESTION_MARK = preload("res://scenes/question_mark.tscn")

func _ready() -> void:
	cloud_hitbox.body_entered.connect(_on_cloud_hitbox_body_entered)

func _process(delta: float) -> void:
	progress += speed * delta
	if progress_ratio >= 1.0:
		queue_free()

func _on_cloud_hitbox_body_entered(_area):
	if randf() < spawn_probability:
		var question_mark: PathFollow2D = QUESTION_MARK.instantiate()
		add_sibling(question_mark)
		question_mark.progress_ratio = progress_ratio
	queue_free()

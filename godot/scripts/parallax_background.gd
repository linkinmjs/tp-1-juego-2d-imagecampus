extends ParallaxBackground

@export var speed:= 100

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	scroll_base_offset.x -= speed * delta

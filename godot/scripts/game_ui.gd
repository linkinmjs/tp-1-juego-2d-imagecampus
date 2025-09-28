extends CanvasLayer

@onready var ammo_label: Label = $PanelContainer/MarginContainer/HBoxContainer/AmmoLabel
@onready var health_label: Label = $PanelContainer/MarginContainer/HBoxContainer/HealthLabel
@onready var score_label: Label = $PanelContainer/MarginContainer/HBoxContainer/ScoreLabel



func _ready() -> void:
	GameManager.update_ammo.connect(_on_update_ammo)
	GameManager.update_health.connect(_on_update_health)
	GameManager.update_score.connect(_on_update_score)
	ammo_label.text = "Ammo: " + str(GameManager.collected_cannon_balls)
	health_label.text = "Health: " + str(GameManager.life)
	score_label.text = "Score: " + str(GameManager.collected_coins)

func _on_update_ammo() -> void:
	ammo_label.text = "Ammo: " + str(GameManager.collected_cannon_balls)
	
func _on_update_health() -> void:
	health_label.text = "Health: " + str(GameManager.life)

func _on_update_score() -> void:
	score_label.text = "Score: " + str(GameManager.collected_coins)

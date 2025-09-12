extends CharacterBody2D

var action_area: Area2D
var pirate: AnimatedSprite2D
var cannon: AnimatedSprite2D
var parrot_in_range: bool = false
@export var pirate_has_cannon: bool = false
@export_enum("captain", "pirate_cannon", "pirate_lookout") var pirate_class: String


func _ready() -> void:
	pirate = get_node("Pirate")
	if pirate_has_cannon:
		cannon = get_node("Cannon")
	action_area = get_node("ActionArea")
	action_area.body_entered.connect(_on_action_area_body_entered)
	action_area.body_exited.connect(_on_action_area_body_exited)

func _process(delta: float) -> void:
	update_animation()

func _on_action_area_body_entered(body: Node):
	parrot_in_range = true
	if pirate_class == "captain":
		GameManager.parrot_on_captain = true
	elif pirate_class == "pirate_cannon":
		GameManager.parrot_on_pirate_cannon = true
	elif pirate_class == "pirate_lookout":
		GameManager.parrot_on_pirate_lookout = true
	
func _on_action_area_body_exited(body: Node):
	parrot_in_range = false
	if pirate_class == "captain":
		GameManager.parrot_on_captain = false
	elif pirate_class == "pirate_cannon":
		GameManager.parrot_on_pirate_cannon = false
	elif pirate_class == "pirate_lookout":
		GameManager.parrot_on_pirate_lookout = false
	print("parrot leaving pirate")

func _unhandled_input(event: InputEvent) -> void:
	## TODO: evitar solapamiento de acciones
	if parrot_in_range and event.is_action_pressed("action"):
		_action_event()
		print("Action on %s" % pirate_class)

func _action_event():
	pirate.play("action")
	if pirate_has_cannon:
		cannon.play("action")

func update_animation():
	if pirate.animation == "action" and pirate.is_playing():
		if pirate_has_cannon and cannon.animation == "action" and cannon.is_playing():
			return
		return
	pirate.play("idle")
	if pirate_has_cannon:
		cannon.play("idle")

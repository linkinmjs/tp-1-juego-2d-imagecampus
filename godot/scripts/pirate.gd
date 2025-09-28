extends CharacterBody2D

const CAPTAIN = GameManager.PIRATES_TYPES[0]
const PIRATE_CANNON = GameManager.PIRATES_TYPES[1]
const PIRATE_LOOKOUT = GameManager.PIRATES_TYPES[2]
const PIRATE_FISHERMAN = GameManager.PIRATES_TYPES[3]

var action_area: Area2D
var pirate: AnimatedSprite2D
var cannon: AnimatedSprite2D
var parrot_in_range: bool = false
@export var pirate_has_cannon: bool = false
@export_enum(CAPTAIN, PIRATE_CANNON, PIRATE_LOOKOUT, PIRATE_FISHERMAN) var pirate_class: String

@onready var alert_animation: AnimationPlayer
@onready var shoot_timer: Timer
@onready var is_shooting: bool = false

func _ready() -> void:
	pirate = get_node("Pirate")
	if pirate_class == PIRATE_CANNON:
		cannon = get_node("Cannon")
		alert_animation = $Alert/AlertAnimation
		shoot_timer = $ShootTimer
		shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	action_area = get_node("ActionArea")
	action_area.body_entered.connect(_on_action_area_body_entered)
	action_area.body_exited.connect(_on_action_area_body_exited)

func _process(_delta: float) -> void:
	update_animation()

func _on_action_area_body_entered(_body: Node):
	parrot_in_range = true
	if pirate_class == CAPTAIN:
		GameManager.parrot_on_captain = true
	elif pirate_class == PIRATE_CANNON:
		GameManager.parrot_on_pirate_cannon = true
	elif pirate_class == PIRATE_LOOKOUT:
		GameManager.parrot_on_pirate_lookout = true
	elif pirate_class == PIRATE_FISHERMAN:
		GameManager.parrot_on_pirate_fisherman = true

func _on_action_area_body_exited(_body: Node):
	parrot_in_range = false
	if pirate_class == CAPTAIN:
		GameManager.parrot_on_captain = false
	elif pirate_class == PIRATE_CANNON:
		GameManager.parrot_on_pirate_cannon = false
	elif pirate_class == PIRATE_LOOKOUT:
		GameManager.parrot_on_pirate_lookout = false
	elif pirate_class == PIRATE_FISHERMAN:
		GameManager.parrot_on_pirate_fisherman = false

func _unhandled_input(event: InputEvent) -> void:
	if parrot_in_range and event.is_action_pressed("action"):
		_action_event()

func _action_event():
	if pirate_class == PIRATE_CANNON:
		pirate_cannon_shoot()
	elif pirate_class == PIRATE_LOOKOUT:
		pirate.play("action")
		GameManager.reveal_sea()
	elif pirate_class == CAPTAIN:
		GameManager.evade()
	else:
		pirate.play("action")

func update_animation():
	if pirate.animation == "action" and pirate.is_playing():
		if pirate_has_cannon and cannon.animation == "action" and cannon.is_playing():
			return
		return
	pirate.play("idle")
	if pirate_has_cannon:
		cannon.play("idle")

func pirate_cannon_shoot() -> void:
	if is_shooting:
		return
	is_shooting = true
	shoot_timer.start()
	if GameManager.collected_cannon_balls > 0:
		GameManager.waste_ammo(1)
		pirate.play("action")
		cannon.play("action")
	else:
		alert_animation.play("alert")
		
func _on_shoot_timer_timeout() -> void:
	is_shooting = false

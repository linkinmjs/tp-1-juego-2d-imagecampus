extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_timer: Timer = $Hitbox/HitTimer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const JUMP_DOWN_VELOCITY = 2

var was_hit: bool = false
var knockback_velocity_x: float = 160.0
var knockback_velocity_y: float = -440.0

func _physics_process(delta: float) -> void:
	
	if was_hit:
		#print(hit_timer.time_left)
		velocity += get_gravity() * delta
		move_and_slide()
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and Input.is_action_pressed("down"):
		global_position.y += JUMP_DOWN_VELOCITY
	elif Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
	
	# Handle action
	if Input.is_action_just_pressed("action"):
		pass
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	update_animation()
	move_and_slide()

func update_animation():
	if animated_sprite_2d.animation == "special" and animated_sprite_2d.is_playing():
		return
	if is_on_floor() and Input.is_action_just_pressed("action"):
		animated_sprite_2d.play("special")
		return
	if is_on_floor():
		animated_sprite_2d.play("idle")
	elif not is_on_floor():
		animated_sprite_2d.play("flying")

func is_hitted() -> void:
	await hit_timer.timeout
	was_hit = false
	print("func is_hitted()")

func _on_hitbox_area_entered(area: Area2D) -> void:
	if !was_hit:
		if Input.is_action_pressed("left"):
			knockback_velocity_x = abs(knockback_velocity_x)
		elif Input.is_action_pressed("right"):
			knockback_velocity_x = -abs(knockback_velocity_x)
		else:
			knockback_velocity_x = 0.0
		velocity = Vector2(knockback_velocity_x, knockback_velocity_y)
		was_hit = true
		hit_timer.start()
		is_hitted()
		GameManager.get_damage(1)

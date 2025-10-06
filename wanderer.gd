extends CharacterBody2D

const BASE_SPEED = 120.0
const SPRINT_MULTIPLIER = 1.5
const JUMP_VELOCITY = -300.0

@onready var anim = $AnimatedSprite2D
@onready var jump_sound = $JumpSound         
@onready var swing_sound = $SwingSound       
@onready var hit_sound = $HurtSound           

var last_direction = "Right"
var is_jumping = false
var was_moving = false
var max_health = 100
var current_health = max_health
var is_dead = false

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		anim.stop()
		if jump_sound:
			jump_sound.play()

	var move_left = Input.is_action_pressed("move_left")
	var move_right = Input.is_action_pressed("move_right")
	var sprinting = Input.is_action_pressed("sprint")

	var speed = BASE_SPEED
	if sprinting:
		speed *= SPRINT_MULTIPLIER

	var moving = false
	if move_left:
		velocity.x = -speed
		last_direction = "Left"
		anim.play("Run Left" if sprinting else "Walking Left")
		moving = true
	elif move_right:
		velocity.x = speed
		last_direction = "Right"
		anim.play("Run Right" if sprinting else "Walking Right")
		moving = true
	else:
		velocity.x = move_toward(velocity.x, 0, BASE_SPEED)

	if not moving and was_moving and is_on_floor() and not is_jumping:
		anim.play("Idle " + last_direction)

	if is_on_floor() and is_jumping:
		is_jumping = false
		anim.play("Idle " + last_direction)

	if Input.is_action_just_pressed("attack"):
		anim.play("Attack " + last_direction)
		
		if swing_sound:
			swing_sound.play()

	was_moving = moving
	move_and_slide()

func apply_damage(amount: int) -> void:
	if is_dead:
		return

	current_health -= amount
	current_health = max(current_health, 0)

	if hit_sound:
		hit_sound.play()

	if current_health == 0:
		die()

func die() -> void:
	is_dead = true
	get_tree().reload_current_scene()

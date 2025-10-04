extends CharacterBody2D

const BASE_SPEED = 120.0
const SPRINT_MULTIPLIER = 1.5
const JUMP_VELOCITY = -300.0

@onready var anim = $AnimatedSprite2D

var last_direction = "Right"
var is_jumping = false
var was_moving = false

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		anim.stop()  # THIS FREEZES ANIMATION FOR JUMP SO IT LOOKS MORE FLUID

	# Movement input
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

	# ts for resetting jump idek vro help ( it works yay ! )
	if is_on_floor() and is_jumping:
		is_jumping = false
		anim.play("Idle " + last_direction)

	was_moving = moving

	move_and_slide()

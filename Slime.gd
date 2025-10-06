extends Node2D

const SPEED: float = 50.0
const MAX_HEALTH: int = 10

@onready var anim = $AnimatedSprite2D
@onready var damage_area = $DamageArea
@onready var raycastleft = $Raycastleft
@onready var raycastright = $Raycastright2

var direction: int = -1
var health: int = MAX_HEALTH
var is_dead: bool = false

func _ready():
	damage_area.body_entered.connect(_on_player_touched)

func _process(delta: float) -> void:
	if is_dead:
		return

	var hit_left: bool = raycastleft and raycastleft.is_colliding()
	var hit_right: bool = raycastright and raycastright.is_colliding()

	if hit_right and not hit_left:
		direction = -1
	elif hit_left and not hit_right:
		direction = 1

	position.x += direction * SPEED * delta
	anim.flip_h = direction == -1
	anim.play("Walking")

func _on_player_touched(body):
	if is_dead:
		return

	if Input.is_action_pressed("text_k
	ey"):
		print("Works")
		die()
	elif body.has_method("apply_damage"):
		body.apply_damage(10)

func die():
	is_dead = true
	anim.play("Death")
	queue_free()

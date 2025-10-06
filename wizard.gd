extends Node2D

@onready var dialogue_resource = preload("res://Wizzard1.dialogue")  # Your .dialogue file
@onready var player_detector = $PlayerDetector  # Area2D or CollisionShape2D

var player_in_range = false

func _ready():
	player_detector.body_entered.connect(_on_body_entered)
	player_detector.body_exited.connect(_on_body_exited)

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("DialogAction"):
		DialogueManager.show_dialogue_balloon(dialogue_resource)  # "intro" is the title block

func _on_body_entered(body):
	if body.name == "Player":
		player_in_range = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false

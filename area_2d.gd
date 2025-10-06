extends Area2D

func _ready():
	body_entered.connect(_on_player_touched)

func _on_player_touched(body):
	if body.name == "Player":
		queue_free()

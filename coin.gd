extends Area2D

@onready var animation_player = $AnimationPlayer

# will create score manager of my own, currently this is fine.
func _on_body_entered(body):
	print("+1 Coin")
	animation_player.play("Coin")
	

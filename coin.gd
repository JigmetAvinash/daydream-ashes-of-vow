extends Area2D


func _on_body_entered(body):
	print("Coin touched by: ", body.name)
	if body.is_in_group("Player"):
		print("Player detected! Adding coin...")
		CoinGameState.add_coin()
		queue_free()
	else:
		print("Not player, groups: ", body.get_groups())

extends Node
signal coins_changed(new_total)
var coins: int = 0

#Used AI to understand how these functions work
func add_coin():
	coins += 1
	emit_signal("coins_changed", coins)
	print("Coins: %d" % coins)
func reset() -> void:
	coins = 0
	emit_signal("coins_changed", coins)
	print("Coins reset to: %d" % coins)

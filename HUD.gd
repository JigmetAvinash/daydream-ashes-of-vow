extends CanvasLayer
@onready var coin_label = $CoinLabel

func _init():
	print("HUD script aagi")

func _ready():
	coin_label.text = "Coins: %d" % CoinGameState.coins
	CoinGameState.coins_changed.connect(_on_coins_changed)
	print("HUD connected to CoinGameState")

func _on_coins_changed(new_total: int) -> void:
	coin_label.text = "Coins: %d" % new_total
	print("HUD updated to: %d" % new_total)

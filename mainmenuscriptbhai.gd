extends Node

func _ready():
	# Buttons are connection for the going on of the game
	$Button.pressed.connect(_on_play_pressed)
	$Button2.pressed.connect(_on_exit_pressed)

func _on_play_pressed():
	# Go to level 1
	get_tree().change_scene_to_file("res://level_1.tscn")

func _on_exit_pressed():
	# Quit game
	get_tree().quit()

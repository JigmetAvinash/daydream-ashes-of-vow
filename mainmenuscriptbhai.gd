extends Node

func _ready():
	$Button.pressed.connect(_on_play_pressed)
	$Button2.pressed.connect(_on_exit_pressed)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://MapLevel3.tscn")

func _on_exit_pressed():
	get_tree().quit()

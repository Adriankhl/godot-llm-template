extends Node


func _on_text_generation_pressed():
	get_tree().change_scene_to_file("res://text_generation.tscn")

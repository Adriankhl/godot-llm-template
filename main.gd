extends Node


func _on_text_generation_pressed():
	get_tree().change_scene_to_file("res://text_generation.tscn")


func _on_embedding_button_pressed():
	get_tree().change_scene_to_file("res://embedding.tscn")


func _on_image_to_text_button_pressed():
	get_tree().change_scene_to_file("res://image_to_text.tscn")

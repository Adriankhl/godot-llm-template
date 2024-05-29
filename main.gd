extends Node

func _ready():
	if (OS.get_name() == "Android"):
		OS.request_permissions()
	#var gdllama = GDLlama.new()
	#gdllama.model_path = "res://models/Phi-3-mini-4k-instruct-q4.gguf"
	#gdllama.n_predict = 20
	#var generated_text = gdllama.generate_text_simple("Hello")
	#print(generated_text)

func _on_text_generation_pressed():
	get_tree().change_scene_to_file("res://text_generation.tscn")


func _on_similarity_button_pressed():
	get_tree().change_scene_to_file("res://similarity.tscn")


func _on_image_to_text_button_pressed():
	get_tree().change_scene_to_file("res://image_to_text.tscn")


func _on_vector_database_button_pressed():
	get_tree().change_scene_to_file("res://db.tscn")

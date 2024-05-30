extends Node

func _ready():
	if (OS.get_name() == "Android"):
		OS.request_permissions()
	
	#var gdllama = GDLlama.new()
	#gdllama.model_path = "./models/Meta-Llama-3-8B-Instruct.Q5_K_M.gguf" ##Your model path
	#gdllama.n_predict = 20
	#var generated_text_1 = gdllama.generate_text_simple("Hello")
	#print(generated_text_1)
	#gdllama.queue_free()
	#
	#var gdembedding= GDEmbedding.new()
	#gdembedding.model_path = "./models/mxbai-embed-large-v1.Q5_K_M.gguf"
	#var array: PackedFloat32Array = gdembedding.compute_embedding("Hello world")
	#print(array)
	#var similarity: float = gdembedding.similarity_cos_string("Hello", "World")
	#print(similarity)
	#gdembedding.queue_free()
	
	#var gdllava = GDLlava.new()
	#gdllava.model_path = "./models/llava-phi-3-mini-int4.gguf"
	#gdllava.mmproj_path = "./models/llava-phi-3-mini-mmproj-f16.gguf"
	#var image = Image.new()
	#image.load("icon.svg")
	#var generated_text_2 = gdllava.generate_text_image("Provide a full description", image)
	#print(generated_text_2)
	#gdllava.queue_free()
	
	#var db = LlmDB.new()
	#db.model_path = "./models/mxbai-embed-large-v1.Q5_K_M.gguf"
	#db.open_db()
	#db.drop_llm_tables(db.table_name)
	#db.meta = [
		#LlmDBMetaData.create_text("id"),
		#LlmDBMetaData.create_int("year"),
		#LlmDBMetaData.create_real("attack")
	#]
	#db.calibrate_embedding_size()
	#db.create_llm_tables()
	#var text = "Godot is financially supported by the Godot Foundation, a non-profit organization formed on August 23rd, 2022 via the KVK (number 87351919) in the Netherlands. The Godot Foundation is responsible for managing donations made to Godot and ensuring that such donations are used to enhance Godot. The Godot Foundation is a legally independent organization and does not own Godot. In the past, the Godot existed as a member project of the Software Freedom Conservancy."
	#db.store_text_by_meta({"year": 2024}, text)
	#print(db.retrieve_similar_texts("godot", "year=2024", 3))
	#db.close_db()
	#db.queue_free()


func _on_text_generation_pressed():
	get_tree().change_scene_to_file("res://text_generation.tscn")


func _on_similarity_button_pressed():
	get_tree().change_scene_to_file("res://similarity.tscn")


func _on_image_to_text_button_pressed():
	get_tree().change_scene_to_file("res://image_to_text.tscn")


func _on_vector_database_button_pressed():
	get_tree().change_scene_to_file("res://db.tscn")

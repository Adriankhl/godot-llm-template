extends Node

var update_label: RichTextLabel
var left_array: PackedFloat32Array = []
var right_array: PackedFloat32Array = []


func _ready():
	$ModelPathLabel.text = $LlamaEmbedding.model_path


func _process(_delta):
	if ($LlamaEmbedding.is_running()):
		llama_embedding_start()
	else:
		llama_embedding_stop()


func llama_embedding_start():
	$ComputeLeftButton.disabled = true
	$ComputeRightButton.disabled = true
	$SimilarityTopButton.disabled = true


func llama_embedding_stop():
	$ComputeLeftButton.disabled = false
	$ComputeRightButton.disabled = false
	$SimilarityTopButton.disabled = false


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_compute_left_button_pressed():
	update_label = $EmbeddingLeft
	update_label.text = ""
	$LlamaEmbedding.run_compute_embedding($PromptLeft.text)


func _on_compute_right_button_pressed():
	llama_embedding_start()
	update_label = $EmbeddingRight
	update_label.text = ""
	$LlamaEmbedding.run_compute_embedding($PromptRight.text)


func _on_model_button_pressed():
	$ModelChooser.popup()


func _on_model_chooser_file_selected(path):
	$LlamaEmbedding.model_path = path


func _on_similarity_top_button_pressed():
	llama_embedding_start()
	$LlamaEmbedding.run_similarity_cos_string($PromptLeft.text, $PromptRight.text)


func _on_llama_embedding_compute_embedding_finished(embedding):
	update_label.text = ""
	if (update_label == $EmbeddingLeft):
		left_array = embedding
	else:
		right_array = embedding
	for f in embedding:
		update_label.text += String.num(f)
		update_label.text += "\n"
	llama_embedding_stop()


func _on_llama_embedding_similarity_cos_string_finished(similarity):
	$SimilarityTop.text = String.num(similarity)
	llama_embedding_stop()


func _on_similarity_bottom_button_pressed():
	$SimilarityBottom.text = String.num($LlamaEmbedding.similarity_cos_array(left_array, right_array))

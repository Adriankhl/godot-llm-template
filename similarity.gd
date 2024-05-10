extends Node

var update_label: RichTextLabel
var left_array: PackedFloat32Array = []
var right_array: PackedFloat32Array = []

var total_time = 0.0

func _ready():
	$ModelPathLabel.text = $Embedding.model_path
	if (OS.get_name() == "Android"):
		$ModelChooser.root_subfolder = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)


func _process(delta):
	total_time += delta
	if (total_time > 1.0):
		if ($Embedding.is_running()):
			embedding_active()
		else:
			embedding_inactive()
		total_time = 0.0


func embedding_active():
	$EmbeddingLeftButton.disabled = true
	$EmbeddingRightButton.disabled = true
	$SimilarityTopButton.disabled = true


func embedding_inactive():
	$EmbeddingLeftButton.disabled = false
	$EmbeddingRightButton.disabled = false
	$SimilarityTopButton.disabled = false


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")



func _on_embedding_left_button_pressed():
	embedding_active()
	update_label = $EmbeddingLeft
	update_label.text = ""
	$Embedding.run_compute_embedding($PromptLeft.text)


func _on_embedding_right_button_pressed():
	embedding_active()
	update_label = $EmbeddingRight
	update_label.text = ""
	$Embedding.run_compute_embedding($PromptRight.text)


func _on_model_button_pressed():
	$ModelChooser.popup()


func _on_model_chooser_file_selected(path):
	$Embedding.model_path = path
	$ModelPathLabel.text = $Embedding.model_path


func _on_similarity_top_button_pressed():
	embedding_active()
	$Embedding.run_similarity_cos_string($PromptLeft.text, $PromptRight.text)


func _on_embedding_compute_embedding_finished(embedding):
	update_label.text = ""
	if (update_label == $EmbeddingLeft):
		left_array = embedding
	else:
		right_array = embedding
	for f in embedding:
		update_label.text += String.num(f)
		update_label.text += "\n"


func _on_embedding_similarity_cos_string_finished(similarity):
	$SimilarityTop.text = String.num(similarity)


func _on_similarity_bottom_button_pressed():
	$SimilarityBottom.text = String.num($Embedding.similarity_cos_array(left_array, right_array))


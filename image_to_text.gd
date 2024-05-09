extends Node


func _ready():
	$ModelPathLabel.text = $Llava.model_path
	$MmprojPathLabel.text = $Llava.mmproj_path
	if (OS.get_name() == "Android"):
		$ModelChooser.root_subfolder = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
		$MmprojChooser.root_subfolder = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
		$ImageChooser.root_subfolder = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)


func _process(_delta):
	if $Llava.is_running():
		llava_active()
	else:
		llava_inactive()

func llava_active():
	$GenFromImage.disabled = true
	$GenFromBase64.disabled = true
	$GenFromView.disabled = true

func llava_inactive():
	$GenFromImage.disabled = false
	$GenFromBase64.disabled = false
	$GenFromView.disabled = false

func _on_image_button_pressed():
	$ImageChooser.popup()


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_image_chooser_file_selected(path):
	var image = Image.new()
	image.load(path)
	var t = ImageTexture.create_from_image(image)
	$ImageScroll/ImageDisplay.texture = t


func _on_base_64_compute_pressed():
	if($ImageScroll/ImageDisplay.texture != null):
		$Base64Edit.text = Marshalls.raw_to_base64($ImageScroll/ImageDisplay.texture.get_image().save_jpg_to_buffer())

func _on_image_compute_pressed():
	var data = Marshalls.base64_to_raw($Base64Edit.text)
	var image = Image.new()
	image.load_jpg_from_buffer(data)
	var t = ImageTexture.create_from_image(image)
	$ImageScroll/ImageDisplay.texture = t


func _on_gen_from_image_pressed():
	$GeneratedText.text = ""
	llava_active()
	if($ImageScroll/ImageDisplay.texture != null):
		$Llava.run_generate_text_image($Prompt.text, $ImageScroll/ImageDisplay.texture.get_image())


func _on_llava_generate_text_updated(new_text):
	$GeneratedText.text += new_text


func _on_gen_from_base_64_pressed():
	$GeneratedText.text = ""
	llava_active()
	$Llava.run_generate_text_base64($Prompt.text, $Base64Edit.text)

func _on_gen_from_view_pressed():
	$GeneratedText.text = ""
	llava_active()
	$Llava.run_generate_text_image($Prompt.text, get_viewport().get_texture().get_image())


func _on_model_button_pressed():
	$ModelChooser.popup()


func _on_model_chooser_file_selected(path):
	$Llava.model_path = path
	$ModelPathLabel.text = path


func _on_mmproj_button_pressed():
	$MmprojChooser.popup()


func _on_mmproj_chooser_file_selected(path):
	$Llava.mmproj_path = path
	$MmprojPathLabel.text = path


func _on_llava_generate_text_finished(text):
	print("full generated text:")
	print(text)


func _on_stop_button_pressed():
	$Llava.stop_generate_text()

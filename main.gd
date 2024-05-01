extends Node


func _ready():
	## Disable the generate button while the thread is running
	$GenerateButton.disabled = $Llama.thread.is_alive()
	$ContinueButton.disabled = true


func _process(_delta):
	## Disable the generate button while the thread is running
	$GenerateButton.disabled = $Llama.thread.is_alive()


func _on_generate_button_pressed():
	$GenerateButton.disabled = true
	$GeneratedText.clear()
	$Llama.run_generate_text($Prompt.text)


func _on_llama_generate_text_updated(new_text):
	$GeneratedText.add_text(new_text)


func _on_continue_button_pressed():
	$ContinueButton.disabled = true
	if ($Prompt.text != ""):
		$GeneratedText.add_text("\n\nPrompt: ")
		$GeneratedText.add_text($Prompt.text)
		$GeneratedText.add_text("\n\nAnswer: ")
	$Llama.input_text($Prompt.text)
	$Prompt.clear()


func _on_stop_generate_button_pressed():
	$Llama.stop_generate_text()


func _on_llama_input_wait_started():
	$ContinueButton.disabled = false


func _on_option_button_item_selected(index):
	match index:
		0:
			$GenerateButton.text = "Generate"
			$Llama.instruct = false
		1:
			$GenerateButton.text = "Start"
			$Llama.instructs = true
	$Prompt.clear()

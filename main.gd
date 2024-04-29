extends Node


func _ready():
	## Disable the generate button while the thread is running
	$GenerateButton.disabled = $Llama.thread.is_alive()


func _process(_delta):
	## Disable the generate button while the thread is running
	$GenerateButton.disabled = $Llama.thread.is_alive()


func _on_generate_button_pressed():
	$GenerateButton.disabled = true
	$GeneratedText.clear()
	$Llama.run_generate_text($Prompt.text)


func _on_llama_generate_text_updated(new_text):
	$GeneratedText.add_text(new_text)


func _on_stop_generate_button_pressed():
	$Llama.stop_generate_text()

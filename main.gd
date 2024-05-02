extends Node

var default_prompt = "Godot Engine is a"

var default_interactive_text = "User: Hi\nAI: Hello. I am an AI chatbot. Would you like to talk?\nUser: Sure!\nAI: What would you like to talk about?\nUser:"


func _ready():
	## Disable the generate button while the thread is running
	$GenerateButton.disabled = $Llama.thread.is_alive()
	$ContinueButton.disabled = true
	$Prompt.text = default_prompt


func _process(_delta):
	## Disable the generate button while the thread is running
	$GenerateButton.disabled = $Llama.thread.is_alive()


func _on_generate_button_pressed():
	$GenerateButton.disabled = true
	$GeneratedText.clear()
	$Llama.run_generate_text($Prompt.text)
	if ($OptionButton.selected != 0):
		$Prompt.clear()


func _on_llama_generate_text_updated(new_text):
	$GeneratedText.add_text(new_text)


func _on_continue_button_pressed():
	$ContinueButton.disabled = true
	if ($Prompt.text != ""):
		match $OptionButton.selected:
			1:
				$GeneratedText.add_text("\n\nPrompt: ")
				$GeneratedText.add_text($Prompt.text)
				$GeneratedText.add_text("\n\nAnswer: ")
			2:
				$GeneratedText.add_text($Llama.input_prefix + $Prompt.text)
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
			$Llama.interactive = false
			$Llama.reverse_prompt = ""
			$Llama.input_prefix = ""
			$Prompt.text = default_prompt
		1:
			$GenerateButton.text = "Start"
			$Llama.instruct = true
			$Llama.interactive = false
			$Llama.reverse_prompt = ""
			$Llama.input_prefix = ""
			$Prompt.clear()
		2:
			$GenerateButton.text = "Start"
			$Llama.instruct = false
			$Llama.interactive = true
			$Llama.reverse_prompt = "User:"
			$Llama.input_prefix = " "
			$Prompt.text = default_interactive_text

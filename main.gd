extends Node

var default_prompt = "Godot Engine is a"

var default_prompt_json = "Main character in a magic world: "

var default_interactive_text = "User: Hi\nAI: Hello. I am an AI chatbot. Would you like to talk?\nUser: Sure!\nAI: What would you like to talk about?\nUser:"

var _person_schema = {
	"type": "object",
	"properties": {
		"name": {
			"type": "string",
			"minLength": 3,
			"maxLength": 20,
		},
		"birthday": {
			"type": "string",
			"format": "date"
		},
		"weapon": {
			 "enum": ["sword", "bow", "wand"],
		},
		"description": {
			"type": "string",
			"minLength": 10,
		},
	},
	"required": ["name", "birthday", "weapon", "description"]
}

var person_schema: String = JSON.stringify(_person_schema)


func _ready():
	## Disable the generate button while the thread is running
	$GenerateButton.disabled = $Llama.thread.is_alive()
	$ContinueButton.disabled = true
	$Prompt.text = default_prompt
	$ModelPathLabel.text = $Llama.model_path


func _process(_delta):
	## Disable the generate button while the thread is running
	$GenerateButton.disabled = $Llama.thread.is_alive()


func _on_generate_button_pressed():
	$GenerateButton.disabled = true
	$GeneratedText.text = ""
	if ($InteractOption.selected == 0 && $SchemaOption.selected == 1):
		$Llama.run_generate_text($Prompt.text, "", person_schema)
	else:
		$Llama.run_generate_text($Prompt.text)

	if ($InteractOption.selected != 0):
		$Prompt.clear()


func _on_llama_generate_text_updated(new_text):
	$GeneratedText.text += new_text


func _on_continue_button_pressed():
	$ContinueButton.disabled = true
	if ($Prompt.text != ""):
		match $InteractOption.selected:
			1:
				$GeneratedText.text += "\n\nPrompt: "
				$GeneratedText.text += $Prompt.text
				$GeneratedText.text += "\n\nAnswer: "
			2:
				$GeneratedText.text += $Llama.input_prefix + $Prompt.text
	$Llama.input_text($Prompt.text)
	$Prompt.clear()


func _on_stop_generate_button_pressed():
	$Llama.stop_generate_text()


func _on_llama_input_wait_started():
	$ContinueButton.disabled = false


func _on_interact_option_item_selected(index):
	match index:
		0:
			$GenerateButton.text = "Generate"
			$Llama.instruct = false
			$Llama.interactive = false
			$Llama.reverse_prompt = ""
			$Llama.input_prefix = ""
			$SchemaOption.disabled = false
			match index:
				0:
					$Prompt.text = default_prompt
				1:
					$Prompt.text = default_prompt_json
		1:
			$GenerateButton.text = "Start"
			$Llama.instruct = true
			$Llama.interactive = false
			$Llama.reverse_prompt = ""
			$Llama.input_prefix = ""
			$SchemaOption.disabled = true
			$Prompt.clear()
		2:
			$GenerateButton.text = "Start"
			$Llama.instruct = false
			$Llama.interactive = true
			$Llama.reverse_prompt = "User:"
			$Llama.input_prefix = " "
			$SchemaOption.disabled = true
			$Prompt.text = default_interactive_text 


func _on_schema_option_item_selected(index):
	match index:
		0:
			$Prompt.text = default_prompt
		1:
			$Prompt.text = default_prompt_json


func _on_model_button_pressed():
	if (OS.get_name() == "Android"):
		$ModelChooser.root_subfolder = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
	$ModelChooser.popup()


func _on_model_chooser_file_selected(path):
	$Llama.model_path = path
	$ModelPathLabel.text = $Llama.model_path

extends Node

class ChatData:
	extends RefCounted
	var character: String
	var text: String

var personal_prompt_a = "Your name is B59, you are an advanced artificial intelligence created by Vault-Tec in the days before the great cataclysm."
var conversation_history: Array[ChatData] = []
var current_character = ""
var max_history = 2

func _ready():
	$GDLlama.context_size = 2048
	$GDLlama.n_predict = 512
	$GDLlama.should_output_prompt = false
	$GDLlama.should_output_special = false



func _process(_delta):
	if ($GDLlama.is_running()):
		$StartButton.disabled = true;
	else:
		$StartButton.disabled = false
		
func prompt_with_history() -> String:
	if (conversation_history.size() > max_history):
		conversation_history.remove_at(0)
	var prompt = ""
	if (current_character == "a"):
		for d in conversation_history:
			if (d.character == "b"):
				prompt += "<|user|>\n" + d.text + "<|end|>\n"
			else:
				prompt += "<|assistant|>\n" + d.text + "<|end|>\n"
	else:
		for d in conversation_history:
			if (d.character == "a"):
				prompt += "<|user|>\n" + d.text + "<|end|>\n"
			else:
				prompt += "<|assistant|>\n" + d.text + "<|end|>\n"
	prompt += "<|assistant|>\n"
	
	#print("Current character: " + current_character)
	#print(prompt)
	
	return prompt


func _on_start_button_pressed():
	current_character = "a"
	var prompt: String =  "<|user|>\n" + personal_prompt_a + "<|end|>\n" + "<|assistant|>\n"
	
	$GDLlama.run_generate_text(prompt, "", "")


func _on_gd_llama_generate_text_finished(text):
	print(current_character + ":")
	print(text)
	var data = ChatData.new()
	data.character = current_character
	data.text = text
	conversation_history.append(data)
	if (current_character == "a"):
		current_character = "b"
	else:
		current_character = "a"
	var prompt: String = prompt_with_history()
	$GDLlama.run_generate_text(prompt, "", "")

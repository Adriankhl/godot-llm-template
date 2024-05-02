extends GDLlama


var thread: Thread = Thread.new()


func _ready():
	## thread becomes inactive after this calls
	thread.start(func(): return)
	if (OS.get_name() == "Android"):
		OS.request_permissions()
		model_path = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP) + "/" + "models/current.gguf"


func _thread_generate_text(prompt: String, grammar: String, json_scheme: String):
	var full_generated_text: String = ""
	if (!grammar.is_empty()):
		full_generated_text = generate_text_grammar(prompt, grammar)
	elif (!json_scheme.is_empty()):
		var json_string = generate_text_json(prompt, json_scheme)

		## An example to show how to extract the generated json substring
		## Be aware that this doesn't work if the input prompt contains curly brackets
		json_string = json_string.right(-json_string.find("{"))
		json_string = json_string.left(json_string.rfind("}") + 1)
		print("Json string:")
		print(json_string)

		# Turn the json into a dictionary
		var dict: Dictionary = {}
		var json = JSON.new()
		var error = json.parse(json_string)
		if (error == OK):
			dict = json.data

		print("Json keys: ")
		print(dict.keys())
		print("Json values: ")
		print(dict.values())
	else:
		full_generated_text = generate_text(prompt)
	print("Full generated text:")
	print(full_generated_text)


## Text generation is slow, use a thread to prevent blocking main thread
func run_generate_text(prompt: String, grammar: String = "", json_scheme: String = ""):
	## Only one extra thread is allowed
	if (thread.is_alive()):
		assert(false, "Llama is already generating text")	
	else:
		thread.wait_to_finish()
		thread = Thread.new()
		thread.start(_thread_generate_text.bind(prompt, grammar, json_scheme))


## Always cleanup the thread
func _exit_tree():
	## Stop the generation to avoid the thread getting stuck, e.g., keep waiting for user input
	stop_generate_text()
	thread.wait_to_finish()

extends GDLlama


var thread: Thread = Thread.new()


func _ready():
	## thread becomes inactive after this calls
	thread.start(func(): return)
	if (OS.get_name() == "Android"):
		OS.request_permissions()
		model_path = OS.get_system_dir(0) + "/" + "models/current.gguf"


func _thread_generate_text(prompt: String):
	var full_generated_text = generate_text(prompt)
	print(full_generated_text)


## Text generation is slow, use a thread to prevent blocking main thread
func run_generate_text(prompt: String):
	## Only one extra thread is allowed
	if (thread.is_alive()):
		assert(false, "Llama is already generating text")	
	else:
		thread.wait_to_finish()
		thread = Thread.new()
		thread.start(_thread_generate_text.bind(prompt))


## Always cleanup the thread
func _exit_tree():
	thread.wait_to_finish()

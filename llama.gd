extends GDLlama

var thread: Thread = Thread.new()


func _thread_generate_text(prompt: String):
	var gt = generate_text(prompt)
	print(gt)

func run_generate_text(prompt: String):
	if (thread.is_alive()):
		assert(false, "Llama is already generating text")	
	else:
		thread.start(_thread_generate_text.bind(prompt))

func _exit_tree():
	thread.wait_to_finish()

extends GDLlama

var thread: Thread = Thread.new()


func _thread_generate_text(prompt: String):
	var gt = generate_text(prompt)
	print(gt)

func run_generate_text(prompt: String):
	thread.wait_to_finish()
	thread.start(_thread_generate_text.bind(prompt))

func _exit_tree():
	thread.wait_to_finish()

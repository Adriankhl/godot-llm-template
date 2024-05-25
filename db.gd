extends Node

var default_document = "
Godot (/ˈɡɒdoʊ/[a]) is a cross-platform, free and open-source game engine released under the permissive MIT license. It was initially developed in Buenos Aires by Argentine software developers Juan Linietsky and Ariel Manzur[6] for several companies in Latin America prior to its public release in 2014.[7] The development environment runs on many platforms, and can export to several more. It is designed to create both 2D and 3D games targeting PC, mobile, and web platforms and can also be used to develop non-game software, including editors. 

Open source is source code that is made freely available for possible modification and redistribution. Products include permission to use the source code,[1] design documents,[2] or content of the product. The open-source model is a decentralized software development model that encourages open collaboration.[3][4] A main principle of open-source software development is peer production, with products such as source code, blueprints, and documentation freely available to the public. The open-source movement in software began as a response to the limitations of proprietary code. The model is used for projects such as in open-source appropriate technology,[5] and open-source drug discovery.[6][7]

Open source promotes universal access via an open-source or free license to a product's design or blueprint, and universal redistribution of that design or blueprint.[8][9] Before the phrase open source became widely adopted, developers and producers used a variety of other terms. Open source gained hold with the rise of the Internet.[10] The open-source software movement arose to clarify copyright, licensing, domain, and consumer issues. 

Linux (/ˈlɪnʊks/ LIN-uuks)[11] is a family of open-source Unix-like operating systems based on the Linux kernel,[12] an operating system kernel first released on September 17, 1991, by Linus Torvalds.[13][14][15] Linux is typically packaged as a Linux distribution (distro), which includes the kernel and supporting system software and libraries, many of which are provided by the GNU Project. Many Linux distributions use the word Linux in their name, but the Free Software Foundation uses and recommends the name GNU/Linux to emphasize the use and importance of GNU software in many distributions, causing some controversy.[16][17] 
"

func _ready():
	$Document.text = default_document
	$ModelPathLabel.text = $LlmDB.model_path
	if (OS.get_name() == "Android"):
		$LlmDB.db_dir = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP) + "/models"
		$ModelChooser.root_subfolder = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
	$LlmDB.open_db()

func _exit_tree():
	$LlmDB.close_db()


func _on_meta_button_pressed():
	$LlmDB.meta = [
		LlmDBMetaData.create("id", LlmDBMetaData.TEXT),
		LlmDBMetaData.create_int("year")
	]

func _on_create_table_button_pressed():
	$LlmDB.calibrate_embedding_size()
	$LlmDB.create_llm_tables()


func _on_drop_table_button_pressed():
	$LlmDB.drop_llm_tables($LlmDB.table_name)


func _on_split_text_button_pressed():
	var array = $LlmDB.split_text($Document.text)
	$Output.text = ""
	for s in array:
		$Output.text += s + "\n\n"


func _on_store_text_button_pressed():
	$LlmDB.run_store_text_by_meta({"year": 2024}, $Document.text)


func _on_retrieve_button_pressed():
	$LlmDB.run_retrieve_similar_texts($Prompt.text, $Filter.text, 3)


func _on_store_text_by_id_button_pressed():
	$LlmDB.store_meta({
		"id": "Document2023",
		"year": 2023,
	})
	$LlmDB.run_store_text_by_id("Document2023", $Document.text)


func _on_llm_db_retrieve_similar_texts_finished(array):
	$Output.text = ""
	for s in array:
		$Output.text += s + "\n\n"


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_model_button_pressed():
	$ModelChooser.visible = true


func _on_model_chooser_file_selected(path):
	$LlmDB.model_path = path
	$ModelPathLabel.text = $LlmDB.model_path


func _on_execute_button_pressed():
	$LlmDB.execute($Prompt.text)

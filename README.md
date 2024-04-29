# Godot LLM template
A demo to show how to use the [godot-llm](https://github.com/Adriankhl/godot-llm) addon

# How to use
1. Clone this project: `git clone https://github.com/Adriankhl/godot-llm-template.git`
2. Download the addon from [godot-llm](https://github.com/Adriankhl/godot-llm) and place it to the `addons` folder
3. Create a `models` folder, download [Meta-Llama-3-8B-Instruct-Q5_K_M.gguf](https://huggingface.co/lmstudio-community/Meta-Llama-3-8B-Instruct-GGUF/tree/main) and place it in `models`
4. Run the project with Godot

Folder and file structure:
```
├── addons
│   └── godot_llm
│       ├── bin
│       │   ├── libgodot_llm.linux.debug.x86_64.so
│       │   ├── libgodot_llm.linux.release.x86_64.so
│       │   ├── libgodot_llm.windows.debug.amd64.dll
│       │   └── libgodot_llm.windows.release.amd64.dll
│       └── godot_llm.gdextension
├── icon.svg
├── icon.svg.import
├── LICENSE
├── llama.gd
├── main.gd
├── main.tscn
├── models
│   └── Meta-Llama-3-8B-Instruct.Q5_K_M.gguf
├── project.godot
└── README.md
```

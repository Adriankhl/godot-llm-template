# Godot LLM template
A demo to show how to use the [godot-llm](https://github.com/Adriankhl/godot-llm) addon

![](./media/demo.gif)

# How to use
You may simply download the Android apk in the release page to try it out for Android devices.

1. Clone this project: `git clone https://github.com/Adriankhl/godot-llm-template.git`
2. Download the addon from [godot-llm](https://github.com/Adriankhl/godot-llm) and place it to the `addons` folder, or get `Godot LLM` directly from the godot asset library
3. Download a model, recommended: [Meta-Llama-3-8B-Instruct-Q5_K_M.gguf](https://huggingface.co/lmstudio-community/Meta-Llama-3-8B-Instruct-GGUF/tree/main) or [Phi-3-mini-4k-instruct-Q2_K.gguf](https://huggingface.co/bartowski/Phi-3-mini-4k-instruct-GGUF/tree/main) for low-end devices such as Android phone
4. Run the project with Godot or export an Android apk (requires the `Manage External Storage` permission)

Folder and file structure:
```
├── addons
│   └── godot_llm
│       ├── bin
│       │   ├── libgodot_llm.android.debug.aarch64.so
│       │   ├── libgodot_llm.android.release.aarch64.so
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
├── media
│   └── demo.gif
├── project.godot
└── README.md
```

Open the application, click `model` and choose the downloaded GGUF file.

You will see there are 3 generation mode: `Simple`, `Instruct`, and `Interactive`. 

# `Simple` mode
Just edit the prompt and click `Generate`.

You choose `None` schema or `Person` schema, if you choose `None` schema, the model will generate the information of a character with Json format.

# `Instruct` mode
Click `Start` first with empty prompt, then modify the prompt and click `Continue` when it is available to talk to the AI. This is an interactive mode. Whenever you see the `Continue` button is available, either input something in the prompt and click `Continue` to send the input, or simply click `Continue` to let the AI talk itself.

# `Interactive` mode
Similar to the instruct mode, except that it relies on a good initial prompt and additoinal reverse prompt and input suffix settings to generate a smooth conversation. The preset prompt should work decently well, click the `Start` button with the preset prompt and start talkin to the AI.

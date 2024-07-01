---
title: 'Whisper Guide'
date: 2024-07-01T00:26:40+02:00
draft: false
tags: ["AI", "audio"]
weight: 10
typora-copy-images-to: ${filename}.assets
summary: null
# cover:
#   image: /poi.jpg
#   caption: "poi"
---

## Install

<a href="https://github.com/openai/whisper"><img alt="Static Badge" src="https://img.shields.io/badge/Github-Whisper-%23181717?style=flat&logo=github"></a>

```shell
conda create -n whisper python=3.11
source activate whisper
sudo apt install ffmpeg
pip install -U openai-whisper
```



## Usage

### Shell

```shell
whisper example.wav \
	--model small \ # small, medium, large, largev2 ...
	--model_dir . \ # default: ~/.cache/whisper
	--task transcribe \
	--language French
```



### Python

```python
import whisper
model = whisper.load_model(name="large-v2", device=device, download_root="./ckpt", in_memory=True)
model.transcribe(**args)
```



### api by Gradio

```python
import gradio as gr
import whisper


model = whisper.load_model(name="small", device="cuda:0", download_root="../ckpt/")


def transcribe(audio_file, language):
    if language is None:
        result = model.transcribe(audio_file)
    else:
        result = model.transcribe(audio_file, language=language)
    return result["text"]


def main():
    audio_input = gr.Audio(sources=["upload", "microphone"], type="filepath")
    lan_input = gr.Dropdown(
        choices=["English", "French", "Chinese", None],
        value=[None]
    )
    text_output = gr.Textbox()
    
    interface = gr.Interface(fn=transcribe, inputs=[audio_input, lan_input], 
                         outputs=[text_output], title="Whisper Transcription",
                         description="Upload audio")
    interface.launch()


if __name__ == '__main__':
    main()
    
```
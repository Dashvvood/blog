---
title: 'Linux Tricks'
date: 2024-07-01T00:32:07+02:00
draft: false
tags: ["default"]
weight: 10
typora-copy-images-to: ${filename}.assets
summary: null
# cover:
#   image: /poi.jpg
#   caption: "poi"
---



## alias

```shell
alias lls='ls -lh --time-style=long-iso'
alias lls='ls -lh --time-style="+%Y-%m-%d %H:%M:%S"'
```



---



## Tmux

### how to reuse

https://github.com/tmux-plugins/tmux-resurrect

**install tmux-resurrect**

```shell
$ git clone https://github.com/tmux-plugins/tmux-resurrect ~/clone/path
run-shell ~/clone/path/resurrect.tmux
```

`tmux.conf`

```shell
bind-key g setw synchronize-panes
bind-key G setw synchronize-panes
bind r source-file ~/.tmux.conf
set -g mouse off # use mouse to operate (not recommended)

# chage prefix from 'Ctrl+b' to 'Alt+b'
# unbind C-b
# set-option -g prefix M-b
# bind-key M-b send-prefix
```

```shell
# activate
tmux source-file ~/.tmux.conf
```

**use**

- `prefix` + <kbd>cltr-s</kbd> 

- `prefix` + <kbd>cltr-r</kbd> 



---

To be continued, :smile_cat:



## Convert

### ppt to pdf on linux

```shell
sudo apt install libreoffice-impress
libreoffice --headless --convert-to pdf example.pptx
# convert example.pptx -> example.pdf using filter : impress_pdf_Export
```



### pdf to jpeg

```shell
# poppler-utils
sudo apt install poppler-utils
pdftoppm -png -f <start-page> -l <end-page> -r <DPI> <name>.pdf <output-prefix>

# ghostscript
gs -dNOPAUSE -sDEVICE=jpeg -r300 -sOutputFile=output-%03d.jpeg input.pdf -c quit

gs -dNOPAUSE -sDEVICE=pngalpha -r300 -dFirstPage=2 -dLastPage=4 -sOutputFile=output-%03d.png input.pdf -c

gs -dNOPAUSE -sDEVICE=png16m -r600  -sOutputFile=document-%02d.png "document.pdf" -dBATCH
```



## Keyboard remapping

```shell
from pynput import keyboard
from pynput.keyboard import Key, Controller

def on_press(key):
    if key == keyboard.Key.caps_lock:
        # Set is_alt to True when Alt key is pressed
        listener.is_alt = True
    elif key == keyboard.KeyCode.from_char('a') and listener.is_alt:
        # Simulate pressing the PrintScreen key when Alt+P is pressed simultaneously
        keyboard_controller.press(Key.print_screen)
        keyboard_controller.release(Key.print_screen)

def on_release(key):
    if key == keyboard.Key.caps_lock:
        # Set is_alt to False when Alt key is released
        listener.is_alt = False

# Create a keyboard listener and keyboard controller
listener = keyboard.Listener(on_press=on_press, on_release=on_release)
keyboard_controller = Controller()

# Start the listener
listener.start()
# Enter the main loop
listener.join()
```



## PS1 Pretty

```shell
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
```



## Conda

1. Download `miniconda` install script from [official site](https://docs.anaconda.com/free/miniconda/)

2. ```shell
   wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
   sudo bash Miniconda3-latest-Linux-x86_64.sh
   ```

3. ```shell
   conda create -y -n py311 python=3.11
   ```

4. ```shell
   source activate py311
   ```

5. ```shell
   pip3 install \
   numpy \
   pandas \
   matplotlib \
   scikit-learn \
   tqdm \
   ipykernel \
   pillow \
   simpy \
   torch torchvision torchaudio \
   requests \
   scipy \
   Flask \
   transformers \
   diffusers \
   huggingface_hub \
   opencv-python
   
   ```
   
6. ```shell
   pip cache purge # clean pip cache (e.g. ~/.cache/pip/)
   ```



## flask update process

```shell
# Add worker
kill -TTIN $masterpid

# Delete worker
kill -TTOU $masterpid

# Reload the configuration
kill -HUP $masterpid
```



---



## ffmpeg

**gif**

```shell
ffmpeg -i input.mp4 output.gif
```

```shell
ffmpeg \
-t 3 \ # duration
-ss 00:00:01 \ # start time
-b 1024k \ # bit rate
-i input.mp4 \
output.mp4
```

**crop**

```shell
ffmpeg -i $file -filter:v "crop=length:height:x:y" $output_file
```

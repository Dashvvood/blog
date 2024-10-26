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
set -g mouse off # use mouse to operate (not recommended)
run-shell ~/clone/path/resurrect.tmux # for tmux resurrect

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



## ssh

- [SSH服务原理和使用技巧](https://www.escapelife.site/posts/e2e78d82.html)
- [史上最全 SSH 暗黑技巧详解](https://plantegg.github.io/2019/06/02/%E5%8F%B2%E4%B8%8A%E6%9C%80%E5%85%A8_SSH_%E6%9A%97%E9%BB%91%E6%8A%80%E5%B7%A7%E8%AF%A6%E8%A7%A3--%E6%94%B6%E8%97%8F%E4%BF%9D%E5%B9%B3%E5%AE%89/)

**ssh config**

```shell
Host TARGET
    HostName X.X.X.X
    User YYY
    Port ZZZ
    ServerAliveInterval 59
    # keep the password(precisely the connection) once connected
    ControlMaster auto
    ControlPath ~/.ssh/sockets/%r@%h-%p  # save the cache
    ControlPersist 30d  # for 30 days
```

**ssh -b**

```shell
A flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 137.194.218.145  netmask 255.255.248.0  broadcast 137.194.223.255

B: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 137.194.250.227  netmask 255.255.240.0  broadcast 137.194.255.255
```

`ssh -b 137.194.250.227 username@ip_addr` use interface B for ssh connection



## ip netns

>**Q :** To use the Wi-Fi network for SSH connections to Node A and the LAN network for SSH connections to Node B, how can I achieve independent connections for each?

https://www.cnblogs.com/sparkdev/p/9253409.html



## Usb Camera

```shell
sudo apt update
sudo apt install v4l-utils
v4l2-ctl --list-devices

USB Camera (usb-0000:00:14.0-3):
    /dev/video0
    /dev/video1

Integrated Camera (usb-0000:00:14.0-5):
    /dev/video2
    /dev/video3

v4l2-ctl --device=/dev/video0 --all

lsusb
```

https://github.com/motioneye-project/motioneye



## Grep Guide

https://www.geeksforgeeks.org/grep-command-in-unixlinux/

| Option    | Description                                                  |
| --------- | ------------------------------------------------------------ |
| `-c`      | This prints only a count of the lines that match a pattern   |
| `-h`      | Display the matched lines, but do not display the filenames. |
| `--i`     | Ignores, case for matching                                   |
| `-l`      | Displays list of filenames only.                             |
| `-n`      | Display the matched lines and their line numbers.            |
| `-v`      | This prints out all the lines that do not match the pattern  |
| `-e exp`  | Specifies expression with this option. Can use multiple times. |
| `-f file` | Takes patterns from file, one per line.                      |
| `-E`      | Treats pattern as an extended regular expression (ERE)       |
| `-w`      | Match whole word                                             |
| `-o`      | Print only the matched parts of a matching line, with each such part on a separate output line. |
| `-A n`    | Prints searched line and `n` lines after the result.         |
| `-B n`    | Prints searched line and `n` lines before the result.        |
| `-C n`    | Prints searched line and `n` lines before and after the result. |



## Docker No Sudo

```shell
sudo groupadd docker
sudo gpasswd -a ${USR} docker
sudo systemctl restart docker
sudo chmod a+rw /var/run/docker.sock

docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```



## WiFi


**network-manager**

```shell
sudo apt install -y network-manager
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

nmcli dev wifi # scan
nmcli dev wifi connect wifi_name password wifi_passwd # connect
# nmcli dev wifi connect wifi_name --ask # interactive way

ip addr show wlan0 # check

# another way : nmtui (graphic interface)
nmcli connection modify "ZEN" connection.autoconnect yes # automatic connection
```



## Bluetooth

```shell
sudo apt update && sudo apt install bluez
sudo apt -y install pulseaudio-module-bluetooth
pulseaudio --start

bluetoothctl
power on
discoverable on
pairable on
bluetoothctl list
bluetoothctl scan on
bluetoothctl devices
bluetoothctl pair 3C:4D:BE:84:1F:BC
bluetoothctl connect 3C:4D:BE:84:1F:BC
bluetoothctl disconnect 3C:4D:BE:84:1F:BC

-scan on
-remove XX:XX:XX:XX:XX:XX, if it had already been paired
-trust XX:XX:XX:XX:XX:XX
-pair XX:XX:XX:XX:XX:XX
-connect XX:XX:XX:XX:XX:XX
```


## Service

**template**

```shell
# /usr/lib/systemd/system/
[Unit]
Description=A new service
After=depend on other service, e.g After=network.service

[Service]
Type=simple
User=Harold
WorkingDirectory=XXX
ExecStart=XXX/a.out --option=123
Restart=on-failure

[Install]
WantedBy=multi-user.target
```



## Encrypting a File

### GPG

```shell
sudo apt-get install gnupg
```

```shell
gpg --full-generate-key
```

- [手把手指导：在 Linux 上使用 GPG 加解密文件](https://linux.cn/article-14082-1.html)

- [GPG 加密解密简明教程](https://gist.github.com/jhjguxin/6037564)

- [加密软件 GPG 入门教程](https://www.yangqi.show/posts/gpg-tutorial)

---


## FRP

https://github.com/fatedier/frp

### frps

```toml
bindAddr = "0.0.0.0"
bindPort = 7000
kcpBindPort = 7000
transport.maxPoolCount = 7

# Configure the web server to enable the dashboard for frps.
# dashboard is available only if webServer.port is set.
webServer.addr = "0.0.0.0"
webServer.port = 7001
webServer.user = "admin"
webServer.password = "admin"

log.to = "./frps.log"
log.level = "info"
log.maxDays = 3

auth.method = "token"
auth.token = "12345"
maxPortsPerClient = 0
udpPacketSize = 1500

# Only allow frpc to bind ports you list. By default, there won't be any limit.
# allowPorts = [
#   { single =  XXX},
#   { start = XXX, end = YYY }
# ]
```

### frpc

```shell
# todo
```


---
title: 'Without a "Q" key, how can I input "Q"?'
date: 2024-10-26T03:24:19+02:00
draft: false
tags: ["default"]
weight: 10
typora-copy-images-to: ${filename}.assets
summary: null
# cover:
#   image: /poi.jpg
#   caption: "poi"
---

>"I love switching to my knife so much while playing CS2 that I ended up breaking my 'Q' key..."

# xmodmap

```shell
xev | grep keycode # get the code of each key input
```

I tried then I got:
```shell
    state 0x0, keycode 23 (keysym 0xff09, Tab), same_screen YES,
    state 0x0, keycode 25 (keysym 0x77, w), same_screen YES,

```

So I think the code for q is `24`

**syntax:**

```shell
xmodmap -e "keycode 25 = w W q Q"
```

- The first key (`w`) is assigned to lowercase when no modifiers are pressed.

- The second key (`W`) is assigned to uppercase (Shift).

- The third key (`q`) would be used with `Mode_switch` (if configured).

- The fourth key (`Q`) would be used with `Mode_switch` + `Shift`.

>So how to set mode_switch?

```shell
xmodmap -e "keysym <KEYSYMBOL> = Mode_switch"
# to use Alt_R as Mode_switch
xmodmap -e "keysym Alt_R = Mode_switch"
# to use Caps_Lock as Mode_switch
xmodmap -e "keysym Caps_Lock = Mode_switch"

# verify the mode_switch
xmodmap -pke | grep Mode_switch
```

**a single file**

```shell
keycode 108 = Mode_switch
keycode 25 = w W q Q
```

run: `xmodmap ~/.Xmodmap`



**Fn BUTTONS**

```shell
keycode 10 = 1 exclam F1 F1
keycode 11 = 2 at F2 F2
keycode 12 = 3 numbersign F3 F3
keycode 13 = 4 dollar F4 F4
keycode 14 = 5 percent F5 F5
keycode 15 = 6 asciicircum F6 F6
keycode 16 = 7 ampersand F7 F7
keycode 17 = 8 asterisk F8 F8
keycode 18 = 9 parenleft F9 F9
keycode 19 = 0 parenright F10 F10
keycode 20 = minus underscore F11 F11
keycode 21 = equal plus F12 F12
```


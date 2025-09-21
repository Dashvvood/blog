---
layout: post
title: AutoHotkey-Usage
date: 2025-09-21 15:01 +0800
---
{% include math.html %}

<https://github.com/AutoHotkey/AutoHotkey>

## Win10 Examples

```
#Requires AutoHotkey v2.0

; 免于挂起：这个热键即使在挂起状态下也能工作
#SuspendExempt True   ; 开启豁免
+XButton1:: {
    Suspend(-1)
    if A_IsSuspended {
        TrayTip "", "AHK 已禁用",  "Mute Icon!"
    } else {
        TrayTip "", "AHK 已启用",  "Mute Iconi" 
    }
    SetTimer () => TrayTip(), -1024
}
#SuspendExempt False  ; 结束豁免


; Shift + 侧键X2 = 打开任务视图
+XButton2:: {
    Send "#{Tab}"
}


; Shift + 鼠标滚轮向上 = 切换上一个虚拟桌面
+WheelUp:: {
    Send("^#{Left}")
    ToolTip("任务视图已打开")  ; 显示提示
    SetTimer(() => ToolTip(), -1000)  ; 1秒后移除提示
}

; Shift + 鼠标滚轮向下 = 切换下一个虚拟桌面
+WheelDown:: {
    Send("^#{Right}")
}
```



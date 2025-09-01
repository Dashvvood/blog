#!/bin/bash

# 步骤1：获取完整格式的时间（含时区）
full_datetime=$(date +"%Y-%m-%d %H:%M %z")
date_part=$(echo "$full_datetime" | cut -d' ' -f1)
echo "Date: $full_datetime"  # 示例输出：2025-09-01 15:30 +0800



# 将标题转换为小写并用“-”替换空格
if [ -z "$1" ]; then
    title="Untitled"
else
    title="$1"
fi
slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
filepath="_posts/$(date +%Y-%m-%d)-$slug.md"
echo "Filepath: $filepath"

if [ -e "$filepath" ]; then
    echo "Error: File '$filepath' already exists."
    exit 1
fi

# 写入内容（带更多元数据）
cat > "$filepath" <<EOF
---
layout: post
title: $title
date: $full_datetime
---
{% include math.html %}
EOF


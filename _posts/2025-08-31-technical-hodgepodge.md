---
layout: post
title: Technical Hodgepodge
date: 2025-08-31 12:00 +0800
---

## Linux

### ssh
**interactive shell**
```bash
shopt -q login_shell && echo "登录式Shell" || echo "非登录式Shell"

# solve this, create ~/.bash_profile and insert
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
```

**SSH key-based authentication**
```shell
ssh-keygen -t ed25519 -C "your_email@example.com"

# if use ssh-copy-id
ssh-copy-id -i ~/.ssh/id_ed25519.pub username@remote_server_ip
# else
mkdir -p ~/.ssh
echo "<pub key>" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
# endif
```


### Parallel Zip
**pigz**(Parallel Implementation of GZip)
**Install**:
```shell
# Debian
sudo apt install pigz
# CentOS/RHEL
sudo yum install pigz
```
**Compress into tar.gz**
```shell
tar -cvf - <target> | pigz -p 8 > output.tar.gz
tar --use-compress-program="pigz -p 8" -cvf output.tar.gz <target>

# pigz supports compression levels (-1 fastest to -9 highest compression):
tar -cvf - directory/file | pigz -9 -p 8 > output.tar.gz  # high compression
```

**Decompress tar.gz**
```shell
pigz -d -p 8 -c input.tar.gz | tar -xvf -
tar --use-compress-program="pigz -d -p 8" -xvf input.tar.gz
```


### Offline Machine
```bash
# Online Machine
conda install -c conda-forge conda-pack
conda pack -n my_env -o my_env.tar.gz
conda pack -n my_env -o numpy.tar.gz --filter=numpy 
# Offline
mkdir -p /opt/miniconda3/envs/my_env 
tar -xzf my_env.tar.gz -C /opt/miniconda3/envs/my_env
conda activate my_env
```

```shell
# Online Machine
# Create a new Conda environment named 'offline_env' with Python 3.9
conda create -n offline_env python=3.9  
# Install numpy and pandas into the environment, but only download packages (no installation)
conda install -n offline_env numpy pandas --download-only -d ./offline_packages

# pass offline_packages from online machine to offline machine

# Offline Machine
# Create an empty environment named 'my_env' (no internet access)
conda create -n my_env --offline  
# Install packages from local .tar.bz2 files
conda install -n my_env --offline --use-local ./offline_packages/*.tar.bz2
```


### Document to file
[**Here Document**](https://en.wikipedia.org/wiki/Here_document)

无内置格式化功能，完全保留文本原貌
```shell
cat > config.yml <<EOF
server:
  port: 8080
  host: $HOSTNAME
EOF
```

**echo**
```shell
echo -e "Line 1\nLine 2\tTabbed" > file.txt # \n换行，\t制表符
```


### Pipe Viewer (pv)
```shell
# 获取进度
tar -cf - $dir | pv -s $(du -sb $dir | awk '{print $1}') > $dir.tar
tar -cf - $dir | pv -s $(du -sb $dir | awk '{print $1}') | pigz -p 8 > $dir.tar.gz
# -: 代表stdout; pv -s根据文件大小评估进度
```

### tail
```shell
tail -n +K：表示​​从文件的第 K 行开始输出，一直输出到文件末尾​​。
tail -n K（或 tail -K）：表示​​输出文件的最后 K 行​​。
```


### parallel

> 这个程序太NB了, 怎么啥功能都有

```shell
-a file​​	parallel -a files.txt wc -l	参数列表已存在于文件中时最方便
​​:::: file​​	parallel wc -l :::: files.txt	功能同 -a，另一种语法，可读性更好
​​:::​​	parallel wc -l ::: file1.txt file2.txt	参数数量较少，直接写在命令行时

# 甚至可以试运行
parallel --dry-run -a tmp.txt -j 4 'cos cp "cos://asr-dig-data-1256237915/{}" "$(basename {})"'
```

### print0的用法
```shell
find downloads/ -name "*.mp3" -print0 | head -z -n 100 | tar --use-compress-program="pigz -p 8" -cf first_100_mp3.tar.gz --null -T -
# head -z
# tar --null
```




### Shell 扩展名获取
```shell
filename="${fullfile##*/}"   # 先从路径中提取出带扩展名的文件名
name="${filename%.*}"        # 移除从最后一个 '.' 开始的后缀，得到文件名
extension="${filename##*.}"  # 移除直到最后一个 '.' 的前缀，得到扩展名
```

### 变量存储时间点
```shell
#!/bin/bash

# 获取当前时间戳（秒级，作为唯一数据源）
current_timestamp=$(date +%s)

# 从同一时间戳生成两种格式
datetime_full=$(date -d "@$current_timestamp" +%Y%m%d%H%M%S)
date_only=$(date -d "@$current_timestamp" +%Y%m%d)

# 输出结果
echo "完整日期时间: $datetime_full"
echo "仅日期: $date_only"
```

### awk 实用样例
```shell
# 多重引号:
watch -n 5 'ls -lh *.tar | awk '\''{print $5, $9}'\'''

# 对比找新的前10个
awk 'BEGIN { IGNORECASE=1 } NR==FNR { archive[$0]; next } !($0 in archive) && !seen[$0]++ { print; if (++count >= '${batch}') exit }' ${archive_file} ${input_file} > ${tmpfile}
```

### Shell 遍历方法归纳
```shell
#!/bin/bashsou
servers=("Server1" "Server2" "Server3" "Server4")
# 遍历 servers 数组的每一个元素
for server in "${servers[@]}"; do
    echo "当前服务器: $server"
done
```
**Shell 数组遍历方式对比表**

### Shell 数组遍历方式对比表

**example**
```shell
# 测试数组（包含空格元素）
files=("Project A" "Project B" "Project C")

# 1. 正确做法："${files[@]}"
for file in "${files[@]}"; do
    echo "文件: $file"
done
# 输出：3次循环，元素保持完整
# 文件: Project A
# 文件: Project B
# 文件: Project C

# 2. 错误示例："${files[*]}"
for file in "${files[*]}"; do
    echo "文件: $file"
done
# 输出：1次循环，所有元素合并
# 文件: Project A Project B Project C

# 3. 危险做法：${files[@]} (无引号)
for file in ${files[@]}; do
    echo "文件: $file"
done
# 输出：4次循环，元素被空格拆分
# 文件: Project
# 文件: A
# 文件: Project
# 文件: B
# 文件: Project C
```

---
layout: post
title: Technical Hodgepodge
date: 2025-08-31 12:00 +0800
---

## Overview

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

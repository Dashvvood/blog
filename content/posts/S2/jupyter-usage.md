---
title: 'Jupyter Usage'
date: 2024-12-15T20:26:12+01:00
draft: false
tags: ["default"]
weight: 10
typora-copy-images-to: ${filename}.assets
summary: null
# cover:
#   image: /poi.jpg
#   caption: "poi"
---

# Jupyter Usage

```shell
conda activate test
# inside test env
pip install jupyterlab ipykernel
# add a new kernel
python -m ipykernel install --user --name test --display-name "conda env(test)"
# use that kernel, select it in jupyter
jupyter lab 
# remove that kernel
jupyter kernelspec uninstall test

# List all kernels installed
jupyter kernelspec list
```

**Port Forwarding**

```shell
ssh -L [local_port]:[remote_host]:[remote_port] user@remote_host
```


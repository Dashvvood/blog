---
layout: post
title: Jupyter Usage
date: 2025-07-28 02:09 +0800
---

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

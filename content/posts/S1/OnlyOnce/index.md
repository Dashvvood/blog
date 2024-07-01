---
title: 'OnlyOnce'
date: 2024-07-01T02:09:01+02:00
draft: true
tags: ["default"]
weight: 10
typora-copy-images-to: ${filename}.assets
summary: null
# cover:
#   image: /poi.jpg
#   caption: "poi"
---

# CGAL

## Installation[^1][^2]

Install g++, cmake, boost

```shell
sudo apt update
sudo apt install -y g++ cmake libboost-all-dev
```

Install GMP and MPFR

- https://gmplib.org/

- https://www.mpfr.org/

```shell
# install gmp gmp-6.3.0
# download source code and decompress
./configure
make
sudo make install
sudo apt install libgmp-dev
# sudo make uninstall 

# install MPFR mpfr-4.2.1
./configure
make
sudo make install
# sudo make uninstall 
```

Install Qt5 by offline-installers

download `qt-opensource-linux-x64-5.12.12.run` from https://www.qt.io/offline-installers

```shell
sudo ./qt-opensource-linux-x64-5.12.12.run
sudo apt-get install libqt5opengl5 libqt5opengl5-dev
```

download CGAL[^3]

```shell
mkdir build && cd build
cmake ..
make install
```



## Reference

[^1]: CGAL https://www.cgal.org/index.html
[^2]: CGAL doc https://doc.cgal.org/latest/Manual/usage.html
[^3]: CGAL github https://github.com/CGAL/cgal/releases


# Project Asiago
Project Asiago is the idea that the current computer system is inheritenly broken, and needs to be fixed. Project Asiago is reinventing this system to achieve it's full potential.

# Major TODOs
 - [ ] operating system
  - [ ] major driver support
 - [ ] Mish parser
 - [ ] non-volatile storage
 - [ ] networking
 - [ ] text formatting specification

# Projects
Here are all the sub-projects in Project Asiago:
 - [Aura](https://github.com/neonorb/aura) - OS
 - [Feta](https://github.com/neonorb/feta) - standard library
 - [Mish](https://github.com/neonorb/mish) - language library
 - [Make Base](https://github.com/neonorb/make-base) - shared management/build scripts
 - [Mish Linux](https://github.com/neonorb/mish-linux) - Linux base for Mish

# Getting
This repository contains a makefile that allows you to easily download and build all the required dependencies.

You'll first need to setup your directories. The rest of this document assumes your current directory is `~/project-asiago/project-asiago/`
```
$ mkdir project-asiago
$ cd project-asiago
$ git clone git@github.com:neonorb/project-asiago
$ cd project-asiago
$ make init
```

Your directory structure should look something like this (`...` means there's more stuff not listed):

```
project-asiago/
├─project-asiago/
│ ├─makefile
│ └─...
├─aura/
│ ├─makefile
│ ├─src/
│ │ └─...
│ └─...
├─mish/
│ └─...
└─...
```

## Aura
If you'd like to use the operating system, you may do so here. No cross compiler required!

```
$ make aura
```

### QEMU
```
# apt install qemu-system-x86_64
$ make run-aura
```

### Bare Metal
Before doing this, make **sure** it's the right disk.

```
# dd if=../aura/build/aura.img of=/dev/sdx bs=1K
```

## On Linux
If you'd like to run Mish code on Linux, you can do this as well.

### Building
```
$ make mish-linux
```

### Installing & Running
If you'd like, you may skip installing Mish, and simply execute the binary directly via: `../mish-linux/build/mish`

Otherwise, you may just install Mish:

```
# make install-linux
$ mish
```

# Contributing
If you'd like to contribute, checkout the issues pages on all the repos. If you find something you want to work on, be it a bug fix or an entirly new feature, go ahead!

You will need a GPG key to sign your commits with, there is a great tutorial over [here](http://blog.dpg.io/articles/gpg-linux). You will also want to [add it to your GitHub account](https://help.github.com/articles/adding-a-new-gpg-key-to-your-github-account/). Once you have the GPG key, you will want to fork the desired repository, make your changes and **make sure you sign the commit**. Then you can submit a push request.

# Code Style Guide
Try to keep the style similar to what we have already. Main points:
 - braces on same line
 - tabs > spaces
 - classes are like this: `MyClassThatIReallyLove`
 - variables: `myVariable`
 - constants: `MY_CONSTANT`
 - functions: `myFunction()`
 - namespaces
# Project Asiago
Project Asiago is the idea that the current computer system is inheritenly broken, and needs to be fixed. Project Asiago is reinventing this system to achieve it's full potential.

# Major TODOs
 - [ ] operating system
  - [ ] major driver support
 - [ ] Mish parser
 - [ ] non-volatile storage
 - [ ] networking
 - [ ] text formatting specification

# Getting
This repository contains a makefile that allows you to easily download and build all the required dependencies.

You'll first need an intial build of everything:
```
$ mkdir project-asiago
$ cd project-asiago
$ git clone git@github.com:neonorb/project-asiago
$ cd project-asiago
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
If you'd like to contribute, you will need a GPG key to sign your commits with. There is a great tutorial over here: http://blog.dpg.io/articles/gpg-linux. Once you have the GPG key, you will want to fork the desired repository, make your changes and **make sure you sign the commit**. Then you can submit a push request.

# Code Style Guide
Try to keep the style similar to what we have already. Main points:
 - braces on same line
 - tabs > spaces
 - classes are like this: `MyClassThatIReallyLove`
 - variables: `myVariable`
 - functions: `myFunction()`
 - unless it's in a module, then separate with underscores: `uefi_terminal_writeString()`

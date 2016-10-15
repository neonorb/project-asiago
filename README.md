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
## Aura
No cross compiler needed!

```
# apt install qemu-system-x86_64
$ mkdir project-asiago
$ cd project-asiago
$ git clone git@github.com:neonorb/project-asiago
$ cd project-asiago
$ make aura
$ make run
```

## On Linux
If you'd like to run Mish code on Linux, you can do this as well.

```
$ mkdir project-asiago
$ cd project-asiago
$ git clone git@github.com:neonorb/project-asiago
$ cd project asiago
$ make mish-linux
$ ../mish-linux/build/mish
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

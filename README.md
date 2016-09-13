# Project Asiago
Project Asiago is the idea that the current computer system is inheritenly broken, and needs to be fixed. Project Asiago is reinventing this system to achieve it's full potential.

# Major Milestones
 - [ ] operating system
  - [ ] major driver support
 - [ ] Mish parser
 - [ ] non-volatile storage
 - [ ] networking
 - [ ] text formatting specification

# Getting
If you'd like to run the operating system in an emulator, you must first install `qemu-system-x86_64`. Then clone this repository and run `make run`. This will clone all the dependencies into the parent folder and build them, it's reccomended you have a dedicated folder for this reason.

```
# apt install qemu-system-x86_64
$ mkdir project-asiago
$ cd project-asiago
$ git clone https://github.com/neonorb/project-asiago
$ cd project-asiago
$ make run
```

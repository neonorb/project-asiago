# Project Asiago
Project Asiago is the idea that the current computer system is inherently broken, and needs to be fixed. Project Asiago is reinventing this system to achieve it's full potential.

## Projects
Here are all the sub-projects in Project Asiago:
 - [Aura](https://github.com/neonorb/aura) - kernel
 - [Feta](https://github.com/neonorb/feta) - standard library
 - [Mish](https://github.com/neonorb/mish) - language library
 - [Mish Linux](https://github.com/neonorb/mish-linux) - Linux base for Mish
 - [Make Base](https://github.com/neonorb/make-base) - shared management/build scripts
 - [Project Asiago](https://github.com/neonorb/project-asiago) - scripts used to build and maintain all these projects

## Getting
This repository contains a makefile that allows you to easily download and build all the required dependencies.

You'll first need to setup your directories and initialize everything. The rest of this document assumes your current directory is `~/project-asiago/project-asiago/`
```
$ mkdir project-asiago # may be a different folder if you'd like
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

### Aura
If you'd like to use the operating system, you may compile it. No cross compiler required!

```
$ make aura
```

#### Running
##### QEMU
```
# apt install qemu-system-x86_64
$ make run-aura
```

##### Bare Metal
Before doing this, make **sure** it's the right disk.

```
# dd if=../aura/build/aura.img of=/dev/sdx bs=1K
```

### On Linux
If you'd like to run Mish code on Linux, you can do this as well.

#### Building
```
$ make mish-linux
```

#### Installing & Running
If you'd like, you may skip installing Mish, and simply execute the binary directly with this command: `../mish-linux/build/mish`

Otherwise, you should just install Mish:

```
# make install-linux
$ mish
```

## Updating
The main repo will regularly get updated, to retrieve these, run `make pull-upstream`.

## Contributing
If you'd like to contribute, take a look at the issue pages on all the repos. If you find something you want to work on, be it a bug fix or an entirly new feature, go ahead!

You will need a GPG key to sign your commits with, there is a great tutorial over [here](http://blog.dpg.io/articles/gpg-linux) to get you started. You will also want to [add it to your GitHub account](https://help.github.com/articles/adding-a-new-gpg-key-to-your-github-account/).

Next, you'll want to fork the desired repository (as you don't have write permissions to the main one). Then you need to update your repository remote locations, to do this, run: `make init GIT_ROOT=git@github.com:<username>`

We use the [Git Flow](http://nvie.com/posts/a-successful-git-branching-model/) branching model, so you'll need to checkout the `develop` branch: `make checkout develop`

Once you make your desired changes, write any necessary unit tests and run them. Although it *should* be automatic, **make sure you sign the commit(s)**.

Once you've done all that, you may submit a push request.

## Code Style Guide
Try to keep the style similar to what we have already. Main points:
 - braces on same line
 - tabs > spaces
 - classes are like this: `MyClassThatIReallyLove`
 - variables: `myVariable`
 - constants: `MY_CONSTANT`
 - functions: `myFunction()`
 - namespaces

# Installing
This repository uses scripts to ease the development and building of several projects at once. You may choose to put all Project Asiago related projects in a separate directory, or mix them in with your other projects. It will require each dependant repo to be in the parent directory of this repository. This is how the structure will be:
```
some_folder/
├─project-asiago/ (this repo)
│ ├─makefile
│ └─...
├─aura/
│ │ └─...
│ └─...
├─mish/
│ └─...
└─...more projects
```

To setup these directories, simply clone this repository wherever you want (again, keep in mind the scripts will add stuff to the parent directory), and run the `init` make target:
```
git clone git@github.com:neonorb/project-asiago
cd project-asiago/
make init
```

## Aura
```
make aura
```

### QEMU
You'll need the `qemu-system-x86_64` package.
```
make run-aura
```

### Bare Metal
Before doing this, make **sure** it's the right disk.
```
dd if=../aura/build/x86_64/aura.img of=/dev/<disk> bs=1K
```

## Backwards Compatible
Since not everybody will be able to switch to the OS completly, Project Asiago offers programs that allow Mish code to be run on other platforms.

### Linux
If you'd like to run Mish code on Linux, you can do this as well.

Build it: `make mish-linux`

You can either execute the binary directly (`../mish-linux/build/x86_64/mish-linux.bin`), or install it to your system: `make install-linux`. Then run it with `mish`.

## Updating
The main repo will regularly get updated, to retrieve these, run `make pull-upstream`.
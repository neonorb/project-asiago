.PHONY:
all: aura

.PHONY:
run: aura
	cd ../aura && make run

.PHONY:
clean:
	cd ../aura && make clean
	cd ../mish && make clean
	cd ../feta && make clean

# ---- building ----

.PHONY:
aura: make-base feta mish
	if [ ! -d ../aura ]; then git clone git@github.com:neonorb/aura ../aura; fi
	cd ../aura && make img
	
.PHONY:
feta: make-base
	if [ ! -d ../feta ]; then git clone git@github.com:neonorb/feta ../feta; fi
	cd ../feta && make lib

.PHONY:
mish: make-base feta
	if [ ! -d ../mish ]; then git clone git@github.com:neonorb/mish ../mish; fi
	cd ../mish && make lib

.PHONY:
make-base:
	if [ ! -d ../make-base ]; then git clone git@github.com:neonorb/make-base ../make-base; fi

# --- Git ----

.PHONY:
commit:
	./commitall.sh

.PHONY:
push:
	cd ../aura && git push
	cd ../make-base && git push
	cd ../mish && git push
	cd ../feta && git push

.PHONY:
commit-push: commit push

.PHONY:
pull:
	cd ../aura && git pull
	cd ../make-base && git pull
	cd ../mish && git pull
	cd ../feta && git pull

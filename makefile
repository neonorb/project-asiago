.PHONY:
run: aura
	cd ../aura && make run

.PHONY:
all: aura

.PHONY:
aura: make-base feta mish
	if [ ! -d ../aura ]; then git clone https://github.com/neonorb/aura ../aura; fi
	cd ../aura && make img
	
.PHONY:
feta: make-base
	if [ ! -d ../feta ]; then git clone https://github.com/neonorb/feta ../feta; fi
	cd ../feta && make lib

.PHONY:
mish: make-base feta
	if [ ! -d ../mish ]; then git clone https://github.com/neonorb/mish ../mish; fi
	cd ../mish && make lib

.PHONY:
make-base:
	if [ ! -d ../make-base ]; then git clone https://github.com/neonorb/make-base ../make-base; fi

.PHONY:
clean:
	cd ../aura && make clean
	cd ../feta && make clean
	cd ../mish && make clean

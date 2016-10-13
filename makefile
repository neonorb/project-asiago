.PHONY:
all: aura mish-linux

.PHONY:
run-aura: aura
	cd ../aura && make run

.PHONY:
run-linux: mish-linux
	cd ../mish-linux && build/mish

.PHONY:
clean:
	cd ../aura       && make clean
	cd ../mish-linux && make clean
	
	cd ../mish       && make clean
	cd ../feta       && make clean

# ---- building ----

.PHONY:
aura: make-base feta mish
	if [ ! -d ../aura ]; then git clone git@github.com:neonorb/aura ../aura; fi
	cd ../aura && make img

.PHONY:
mish-linux: make-base feta mish
	if [ ! -d ../mish-linux ]; then git clone git@github.com:neonorb/mish-linux ../mish-linux; fi
	cd ../mish-linux && make

# libs
	
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

COMMIT_COMMAND=bash ../project-asiago/commit.sh ; echo ""

.PHONY:
commit:
	$(COMMIT_COMMAND)
	
	cd ../aura       && $(COMMIT_COMMAND)
	cd ../mish-linux && $(COMMIT_COMMAND)
	
	cd ../make-base  && $(COMMIT_COMMAND)
	cd ../mish       && $(COMMIT_COMMAND)
	cd ../feta       && $(COMMIT_COMMAND)

.PHONY:
push:
	git push
	
	cd ../aura       && git push
	cd ../mish-linux && git push
	
	cd ../make-base  && git push
	cd ../mish       && git push
	cd ../feta       && git push

.PHONY:
commit-push: commit push

.PHONY:
pull:
	git pull
	
	cd ../aura       && git pull
	cd ../mish-linux && git pull
	
	cd ../make-base  && git pull
	cd ../mish       && git pull
	cd ../feta       && git pull

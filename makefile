REPOS = project-asiago aura mish-linux mish feta make-base

# use the rest as arguments
ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
# ...and turn them into do-nothing targets
$(eval $(ARGS):;@:)

.PHONY:
all: aura mish-linux

.PHONY:
rebuild: clean all

.PHONY:
clean:
	@$(foreach repo,$(filter-out project-asiago make-base,$(REPOS)), \
	cd ../$(repo) && make -s clean \
	;)
	
.PHONY:
init:
	@$(foreach repo,$(REPOS), \
	if [ ! -d ../$(repo) ]; then git clone git@github.com:neonorb/$(repo) ../$(repo); fi && \
	cd ../$(repo) && git config --local --add commit.gpgsign true \
	;)

# ---- running ----

.PHONY:
run-aura: aura
	@cd ../aura && make -s run

.PHONY:
run-aura-cli: aura
	@cd ../aura && make -s run-cli

.PHONY:
run-linux: mish-linux
	@cd ../mish-linux && build/mish

# ---- building ----

.PHONY:
aura: make-base feta mish
	@cd ../aura && make -s img

.PHONY:
mish-linux: make-base feta mish
	@cd ../mish-linux && make -s

# libs
	
.PHONY:
feta: make-base
	@cd ../feta && make -s lib

.PHONY:
mish: make-base feta
	@cd ../mish && make -s lib

.PHONY:
make-base:

# ---- install ----

install-linux: mish-linux
	@cd ../mish-linux && make -s install

# --- test ---

.PHONY:
test-mish: clean
	@DEBUGGING=true ALLOW_TEST=true make -s mish-linux
	@valgrind --track-origins=yes --read-var-info=yes --leak-check=full --show-leak-kinds=all --show-mismatched-frees=no ../mish-linux/build/mish --test 2>&1 | more

.PHONY:
test-aura: clean
	@DO_TEST=true make -s aura
	@make -s run-aura

# --- Git ----

COMMIT_COMMAND=bash ../project-asiago/commit.sh ; echo ""

.PHONY:
commit:
	@$(foreach repo,$(REPOS), \
	echo $(repo)... && cd ../$(repo) && $(COMMIT_COMMAND) \
	;)

.PHONY:
push:
	@$(foreach repo,$(REPOS), \
	echo $(repo)... && cd ../$(repo) && git push --all \
	;)

.PHONY:
commit-push: commit push

.PHONY:
pull:
	@$(foreach repo,$(REPOS), \
	echo $(repo)... && cd ../$(repo) && git pull --all \
	;)

.PHONY:
checkout:
	@$(foreach repo,$(REPOS), \
	echo $(repo)... && cd ../$(repo) && git checkout $(ARGS) \
	;)

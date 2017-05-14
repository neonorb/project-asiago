REPOS=project-asiago aura mish-linux mish feta make-base mish-android mish-bot motal danbo

# use the rest as arguments
ARGS:=$(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
# ...and turn them into do-nothing targets
$(eval $(ARGS):;@:)

.PHONY:
all: aura mish-linux mish-bot feta mish danbo #motal

.PHONY:
rebuild:
	$(NO_PRINT_COMMAND) $(MAKE) $(NO_PRINT_COMMAND_FLAG) clean
	$(NO_PRINT_COMMAND) $(MAKE) $(NO_PRINT_COMMAND_FLAG) all

.PHONY:
clean:
	$(NO_PRINT_COMMAND)$(foreach repo,$(filter-out project-asiago make-base mish-android,$(REPOS)), \
	$(MAKE) -C ../$(repo) $(NO_PRINT_COMMAND_FLAG) clean \
	;)

# the upstream username
GIT_ROOT_ORIGINAL=git@github.com:neonorb/
# the origin username; if you forked, set it like this: make init GIT_ROOT=git@github.com:<username>/
GIT_ROOT?=$(GIT_ROOT_ORIGINAL)
.PHONY:
init:
	$(NO_PRINT_COMMAND)$(foreach repo,$(REPOS), \
	if [ ! -d ../$(repo) ]; then echo "cloning $(repo)..."; git clone $(GIT_ROOT)$(repo) ../$(repo); fi && \
	(cd ../$(repo) && \
	git remote set-url origin $(GIT_ROOT)$(repo) && \
	git branch --set-upstream-to=origin/develop develop && \
	git remote add upstream url-placeholder 2>/dev/null || \
	git remote set-url upstream $(GIT_ROOT_ORIGINAL)$(repo) && \
	git config --local --add commit.gpgsign true) \
	;)

NO_PRINT_COMMAND_FLAG=$(if $(PRINT_COMMANDS),,-s)
NO_PRINT_COMMAND=$(if $(PRINT_COMMANDS),,@)

OPTS?=

# ---- running ----

.PHONY:
run-aura: aura
	$(NO_PRINT_COMMAND)cd ../aura && $(MAKE) $(NO_PRINT_COMMAND_FLAG) run

debug-aura: clean
	$(NO_PRINT_COMMAND)DEBUGGING=true $(MAKE) $(NO_PRINT_COMMAND_FLAG) aura
	$(NO_PRINT_COMMAND)cd ../aura && ./debug.sh

.PHONY:
run-linux: mish-linux
	$(NO_PRINT_COMMAND)cd ../mish-linux && build/x86_64/mish-linux.bin

.PHONY:
run-bot: mish-bot
	$(NO_PRINT_COMMAND)cd ../mish-bot && build/x86_64/mish-bot.bin --token-env

# --- testing ---

.PHONY:
test-all: test-mish-linux test-aura

.PHONY:
test-mish-linux: clean
	$(NO_PRINT_COMMAND)ALLOW_TEST=true DEBUGGING=true $(MAKE) $(NO_PRINT_COMMAND_FLAG) mish-linux
	$(NO_PRINT_COMMAND)valgrind --track-origins=yes --read-var-info=yes --leak-check=full --show-leak-kinds=all --show-mismatched-frees=no ../mish-linux/build/x86_64/mish-linux.bin --test 2>&1 | more

.PHONY:
debugtest-mish-linux: clean
	$(NO_PRINT_COMMAND)ALLOW_TEST=true DEBUGGING=true $(MAKE) $(NO_PRINT_COMMAND_FLAG) mish-linux
	$(NO_PRINT_COMMAND)gdb --args ../mish-linux/build/x86_64/mish-linux.bin --test

.PHONY:
test-aura: clean
	$(NO_PRINT_COMMAND)AURA_DOTEST=true $(MAKE) $(NO_PRINT_COMMAND_FLAG) aura
	$(NO_PRINT_COMMAND)TESTING=true $(MAKE) $(NO_PRINT_COMMAND_FLAG) run-aura

debugtest-aura: clean
	$(NO_PRINT_COMMAND)DEBUGGING=true ALLOW_TEST=true AURA_DOTEST=true $(MAKE) $(NO_PRINT_COMMAND_FLAG) aura
	$(NO_PRINT_COMMAND)cd ../aura && ./debug.sh

# ---- building ----

.PHONY:
aura: make-base feta mish danbo
	$(NO_PRINT_COMMAND)echo Aura...
	$(NO_PRINT_COMMAND)+ $(MAKE) -C ../aura $(OPTS) $(NO_PRINT_COMMAND_FLAG) img

.PHONY:
mish-linux: make-base feta mish danbo
	$(NO_PRINT_COMMAND) echo Mish Linux...
	$(NO_PRINT_COMMAND)+ $(MAKE) -C ../mish-linux $(OPTS) $(NO_PRINT_COMMAND_FLAG)

.PHONY:
mish-bot: make-base feta mish danbo
	$(NO_PRINT_COMMAND) echo Mish Bot...
	$(NO_PRINT_COMMAND)+ $(MAKE) -C ../mish-bot $(OPTS) $(NO_PRINT_COMMAND_FLAG)

.PHONY:
motal: make-base feta mish danbo
	$(NO_PRINT_COMMAND) echo Motal...
	$(NO_PRINT_COMMAND)+ $(MAKE) -C ../motal $(OPTS) $(NO_PRINT_COMMAND_FLAG)

# libs
	
.PHONY:
feta: make-base
	$(NO_PRINT_COMMAND) echo Feta...
	$(NO_PRINT_COMMAND)+ $(MAKE) -C ../feta $(OPTS) $(NO_PRINT_COMMAND_FLAG) lib

.PHONY:
mish: make-base feta danbo
	$(NO_PRINT_COMMAND) echo Mish...
	$(NO_PRINT_COMMAND)+ $(MAKE) -C ../mish $(OPTS) $(NO_PRINT_COMMAND_FLAG) lib

.PHONY:
danbo: make-base feta
	$(NO_PRINT_COMMAND) echo Danbo...
	$(NO_PRINT_COMMAND)+ $(MAKE) -C ../danbo $(OPTS) $(NO_PRINT_COMMAND_FLAG) lib

.PHONY:
make-base:

# ---- install ----

install-linux: mish-linux
	$(NO_PRINT_COMMAND) $(MAKE) -C ../mish-linux $(NO_PRINT_COMMAND_FLAG) install

# ---- Git ----

COMMIT_COMMAND=bash ../project-asiago/commit.sh ; echo ""

.PHONY:
commit:
	$(NO_PRINT_COMMAND)$(foreach repo,$(REPOS), \
	echo $(repo)... && cd ../$(repo) && $(COMMIT_COMMAND) \
	;)

.PHONY:
push:
	$(NO_PRINT_COMMAND)$(foreach repo,$(REPOS), \
	echo $(repo)... && cd ../$(repo) && git push --all \
	;)

.PHONY:
commit-push: commit push

.PHONY:
pull:
	$(NO_PRINT_COMMAND)$(foreach repo,$(REPOS), \
	echo $(repo)... && cd ../$(repo) && git pull \
	;)

.PHONY:
pull-upstream:
	$(NO_PRINT_COMMAND)$(foreach repo,$(REPOS), \
	echo $(repo)... && cd ../$(repo) && git pull upstream `git rev-parse --abbrev-ref HEAD` \
	;)

.PHONY:
checkout:
	$(NO_PRINT_COMMAND)$(foreach repo,$(REPOS), \
	echo $(repo)... && cd ../$(repo) && git checkout $(ARGS) \
	;)

-include ../make-base/make-git.mk

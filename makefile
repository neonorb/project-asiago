REPOS=project-asiago aura mish-linux mish feta make-base mish-android mish-bot motal danbo

# use the rest as arguments
ARGS:=$(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
# ...and turn them into do-nothing targets
$(eval $(ARGS):;@:)

.PHONY:
all: aura mish-linux mish-bot feta mish danbo #motal

.PHONY:
rebuild: clean all

.PHONY:
clean:
	$(NO_PRINT_COMMAND)$(foreach repo,$(filter-out project-asiago make-base mish-android,$(REPOS)), \
	cd ../$(repo) && make $(NO_PRINT_COMMAND_FLAG) clean \
	;)

# the upstream username
GIT_ROOT_ORIGINAL=git@github.com:neonorb/
# the origin username; if you forked, set it like this: make init GIT_ROOT=git@github.com:<username>/
GIT_ROOT=$(GIT_ROOT_ORIGINAL)
.PHONY:
init:
	@$(foreach repo,$(REPOS), \
	if [ ! -d ../$(repo) ]; then echo "cloning $(repo)"; git clone $(GIT_ROOT)$(repo) ../$(repo); fi && \
	(cd ../$(repo) && \
	git remote set-url origin $(GIT_ROOT)$(repo) && \
	git branch --set-upstream-to=origin/develop develop && \
	git remote add upstream url-placeholder 2>/dev/null || \
	git remote set-url upstream $(GIT_ROOT_ORIGINAL)$(repo) && \
	git config --local --add commit.gpgsign true) \
	;)

NO_PRINT_COMMAND_FLAG=$(if $(PRINT_COMMANDS),,-s)
NO_PRINT_COMMAND=$(if $(PRINT_COMMANDS),,@)

# ---- running ----

.PHONY:
run-aura: aura
	@cd ../aura && make $(NO_PRINT_COMMAND_FLAG) run

debug-aura: clean
	@DEBUGGING=true make $(NO_PRINT_COMMAND_FLAG) aura
	@cd ../aura && ./debug.sh

.PHONY:
run-linux: mish-linux
	@cd ../mish-linux && build/x86_64/mish-linux.bin

.PHONY:
run-bot: mish-bot
	@cd ../mish-bot && build/x86_64/mish-bot.bin --token-env

# --- testing ---

.PHONY:
test-all: test-mish-linux test-aura

.PHONY:
test-mish-linux: clean
	@ALLOW_TEST=true DEBUGGING=true make $(NO_PRINT_COMMAND_FLAG) mish-linux
	@valgrind --track-origins=yes --read-var-info=yes --leak-check=full --show-leak-kinds=all --show-mismatched-frees=no ../mish-linux/build/x86_64/mish-linux.bin --test 2>&1 | more

.PHONY:
debugtest-mish-linux: clean
	@ALLOW_TEST=true DEBUGGING=true make $(NO_PRINT_COMMAND_FLAG) mish-linux
	@gdb --args ../mish-linux/build/x86_64/mish-linux.bin --test

.PHONY:
test-aura: clean
	@AURA_DOTEST=true make $(NO_PRINT_COMMAND_FLAG) aura
	@TESTING=true make $(NO_PRINT_COMMAND_FLAG) run-aura

debugtest-aura: clean
	@DEBUGGING=true ALLOW_TEST=true AURA_DOTEST=true make $(NO_PRINT_COMMAND_FLAG) aura
	@cd ../aura && ./debug.sh

# ---- building ----

.PHONY:
aura: make-base feta mish danbo
	@echo Aura...
	@cd ../aura && make $(NO_PRINT_COMMAND_FLAG) img

.PHONY:
mish-linux: make-base feta mish danbo
	@echo Mish Linux...
	@cd ../mish-linux && make $(NO_PRINT_COMMAND_FLAG)

.PHONY:
mish-bot: make-base feta mish danbo
	@echo Mish Bot...
	@cd ../mish-bot && make $(NO_PRINT_COMMAND_FLAG)

.PHONY:
motal: make-base feta mish danbo
	@echo Motal...
	@cd ../motal && make $(NO_PRINT_COMMAND_FLAG)

# libs
	
.PHONY:
feta: make-base
	@echo Feta...
	@cd ../feta && make $(NO_PRINT_COMMAND_FLAG) lib

.PHONY:
mish: make-base feta danbo
	@echo Mish...
	@cd ../mish && make $(NO_PRINT_COMMAND_FLAG) lib

.PHONY:
danbo: make-base feta
	@echo Danbo...
	@cd ../danbo && make $(NO_PRINT_COMMAND_FLAG) lib

.PHONY:
make-base:

# ---- install ----

install-linux: mish-linux
	@cd ../mish-linux && make $(NO_PRINT_COMMAND_FLAG) install

# ---- Git ----

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
	echo $(repo)... && cd ../$(repo) && git pull \
	;)

.PHONY:
pull-upstream:
	@$(foreach repo,$(REPOS), \
	echo $(repo)... && cd ../$(repo) && git pull upstream `git rev-parse --abbrev-ref HEAD` \
	;)

.PHONY:
checkout:
	@$(foreach repo,$(REPOS), \
	echo $(repo)... && cd ../$(repo) && git checkout $(ARGS) \
	;)

-include ../make-base/make-git.mk

#!/usr/bin/env bash

help:
	echo "Help is not yet implimented"

all: DDDB SIMCOND LHCBCOND DQFLAGS upgrade-DDDB upgrade-SIMCOND

init:
	git submodule init
	git submodule update

DDDB: init
	./scripts/load-database-into-git.sh DDDB

SIMCOND: init
	./scripts/load-database-into-git.sh SIMCOND

LHCBCOND: init
	./scripts/load-database-into-git.sh LHCBCOND

DQFLAGS: init
	./scripts/load-database-into-git.sh DQFLAGS

upgrade-DDDB: init
	./scripts/load-database-into-git.sh DDDB Upgrade

upgrade-SIMCOND: init
	./scripts/load-database-into-git.sh SIMCOND Upgrade

clean:
	-@rm -rf scripts/logs/*.log 2>/dev/null || true

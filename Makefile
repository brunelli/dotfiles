PKGS    ?=
DESTDIR ?= $(HOME)
SYSTEM  ?= $(shell uname -o)
VERBOSE ?= 1

ifndef PKGS
    ifneq ($(shell grep -c -E "^$(SYSTEM) ?=" .systems 2> /dev/null),0)
        PKGS = $(shell grep -E "^\* ?=" .systems | cut -f2- -d= | tail -n1)
        PKGS += $(shell grep -E "^$(SYSTEM) ?=" .systems | cut -f2- -d= | tail -n1)
    else
        $(error No setup defined for system '$(SYSTEM)')
    endif
endif

ifeq ($(PKGS),)
    $(error Nothing to do)
endif

override PKGS := $(shell for PKG in $(PKGS); do printf "%s\n" "$${PKG}"; done | sed -e 's/^-/\\-/g' -e 's/.*/"&"/g')

all: none

none:
	@echo "Everything is in place, run 'make install'"

install:
	@stow --verbose="$(VERBOSE)" --target="$(DESTDIR)" --stow $(PKGS)

uninstall:
	@stow --verbose="$(VERBOSE)" --target="$(DESTDIR)" --delete $(PKGS)

.PHONY: install uninstall

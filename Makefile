.PHONY: all install uninstall

all:
	@echo "Run 'make install' to install Dicta Linux"

install:
	@bash ./install.sh

uninstall:
	@bash ./uninstall.sh

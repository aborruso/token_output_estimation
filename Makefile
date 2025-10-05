PREFIX ?= /usr/local/bin
SCRIPT = token_evaluate
TARGET = $(PREFIX)/$(SCRIPT)

.PHONY: install uninstall

install:
	install -m 755 $(SCRIPT) $(TARGET)
	@echo "Installation complete: $(TARGET)"

uninstall:
	rm -f $(TARGET)
	@echo "Removed: $(TARGET)"

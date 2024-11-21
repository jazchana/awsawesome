# Installation directories
INSTALL_DIR = $(HOME)/.local/share/aws-helpers
SCRIPT_NAME = aws-helper-functions.sh
COMPLETION_DIR = $(HOME)/.local/share/zsh/site-functions

# Detect shell and profile file
SHELL_TYPE := $(shell basename "$$SHELL")
ifeq ($(SHELL_TYPE),bash)
    PROFILE_FILE := $(HOME)/.bashrc
    COMPLETION_FILE := awsm.bash
    COMPLETION_INSTALL_DIR := $(INSTALL_DIR)/completions
else ifeq ($(SHELL_TYPE),zsh)
    PROFILE_FILE := $(HOME)/.zshrc
    COMPLETION_FILE := _awsm
    COMPLETION_INSTALL_DIR := $(COMPLETION_DIR)
else
    PROFILE_FILE := $(HOME)/.profile
    COMPLETION_FILE := awsm.bash
    COMPLETION_INSTALL_DIR := $(INSTALL_DIR)/completions
endif

.PHONY: install uninstall

install:
	@mkdir -p $(INSTALL_DIR)
	@mkdir -p $(COMPLETION_INSTALL_DIR)
	@cp src/$(SCRIPT_NAME) $(INSTALL_DIR)/
	@cp completions/$(COMPLETION_FILE) $(COMPLETION_INSTALL_DIR)/
	@if ! grep -q "source $(INSTALL_DIR)/$(SCRIPT_NAME)" $(PROFILE_FILE); then \
		echo "\n# AWS Helper Functions" >> $(PROFILE_FILE); \
		echo "source $(INSTALL_DIR)/$(SCRIPT_NAME)" >> $(PROFILE_FILE); \
		if [ "$(SHELL_TYPE)" = "bash" ]; then \
			echo "source $(COMPLETION_INSTALL_DIR)/$(COMPLETION_FILE)" >> $(PROFILE_FILE); \
		elif [ "$(SHELL_TYPE)" = "zsh" ]; then \
			echo "fpath=($(COMPLETION_INSTALL_DIR) \$$fpath)" >> $(PROFILE_FILE); \
			echo "autoload -U compinit" >> $(PROFILE_FILE); \
			echo "compinit" >> $(PROFILE_FILE); \
		fi \
	fi
	@echo "Installed AWS helper functions to $(INSTALL_DIR)/$(SCRIPT_NAME)"
	@echo "Installed completions to $(COMPLETION_INSTALL_DIR)/$(COMPLETION_FILE)"
	@echo "Added source lines to $(PROFILE_FILE)"
	@if [ "$(SHELL_TYPE)" = "zsh" ]; then \
		echo "Note: Please restart your shell for completions to take effect"; \
	else \
		echo "Please restart your shell or run: source $(PROFILE_FILE)"; \
	fi

uninstall:
	@rm -f $(INSTALL_DIR)/$(SCRIPT_NAME)
	@rm -f $(COMPLETION_INSTALL_DIR)/$(COMPLETION_FILE)
	@sed -i.bak '/# AWS Helper Functions/d' $(PROFILE_FILE)
	@sed -i.bak '\#source $(INSTALL_DIR)/$(SCRIPT_NAME)#d' $(PROFILE_FILE)
	@if [ "$(SHELL_TYPE)" = "bash" ]; then \
		sed -i.bak '\#source $(COMPLETION_INSTALL_DIR)/$(COMPLETION_FILE)#d' $(PROFILE_FILE); \
	elif [ "$(SHELL_TYPE)" = "zsh" ]; then \
		sed -i.bak '\#fpath=($(COMPLETION_INSTALL_DIR) \$$fpath)#d' $(PROFILE_FILE); \
	fi
	@rm -f $(PROFILE_FILE).bak
	@rmdir $(COMPLETION_INSTALL_DIR) 2>/dev/null || true
	@rmdir $(INSTALL_DIR) 2>/dev/null || true
	@echo "Uninstalled AWS helper functions"

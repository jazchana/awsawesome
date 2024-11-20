PREFIX ?= /usr/local
INSTALL_PATH = $(PREFIX)
BASH_COMPLETION_DIR = $(shell brew --prefix)/etc/bash_completion.d
ZSH_COMPLETION_DIR = $(shell brew --prefix)/share/zsh/site-functions

.PHONY: local-install local-uninstall

local-install:
	@echo "Installing awsm..."
	# Create installation directory
	sudo mkdir -p $(INSTALL_PATH)/share/awsm
	# Install the script
	sudo install -m 755 src/aws-helper-functions.sh $(INSTALL_PATH)/share/awsm/aws-helper-functions.sh
	# Add source command to shell profile if not already present
	@if [ -f ~/.zprofile ] && ! grep -q "source $(INSTALL_PATH)/share/awsm/aws-helper-functions.sh" ~/.zprofile; then \
		echo '\n# AWS Helper Functions\nsource $(INSTALL_PATH)/share/awsm/aws-helper-functions.sh' >> ~/.zprofile; \
		echo "Added source line to ~/.zprofile"; \
	fi
	@if [ -f ~/.bash_profile ] && ! grep -q "source $(INSTALL_PATH)/share/awsm/aws-helper-functions.sh" ~/.bash_profile; then \
		echo '\n# AWS Helper Functions\nsource $(INSTALL_PATH)/share/awsm/aws-helper-functions.sh' >> ~/.bash_profile; \
		echo "Added source line to ~/.bash_profile"; \
	fi
	@echo "Installing completions..."
	sudo mkdir -p $(BASH_COMPLETION_DIR)
	sudo mkdir -p $(ZSH_COMPLETION_DIR)
	sudo install -m 644 completions/awsm.bash $(BASH_COMPLETION_DIR)/awsm
	sudo install -m 644 completions/awsm.zsh $(ZSH_COMPLETION_DIR)/_awsm
	@echo "\nInstallation complete! Please restart your terminal or run:"
	@echo "  source ~/.zprofile    # if you use zsh"
	@echo "  source ~/.bash_profile # if you use bash"

local-uninstall:
	@echo "Uninstalling awsm..."
	sudo rm -f $(INSTALL_PATH)/share/awsm/aws-helper-functions.sh
	sudo rmdir $(INSTALL_PATH)/share/awsm 2>/dev/null || true
	# Remove source line from shell profiles
	@if [ -f ~/.zprofile ]; then \
		sed -i.bak '/# AWS Helper Functions/d' ~/.zprofile; \
		sed -i.bak '/source.*aws-helper-functions.sh/d' ~/.zprofile; \
		rm -f ~/.zprofile.bak; \
	fi
	@if [ -f ~/.bash_profile ]; then \
		sed -i.bak '/# AWS Helper Functions/d' ~/.bash_profile; \
		sed -i.bak '/source.*aws-helper-functions.sh/d' ~/.bash_profile; \
		rm -f ~/.bash_profile.bak; \
	fi
	# Remove completions
	sudo rm -f $(BASH_COMPLETION_DIR)/awsm
	sudo rm -f $(ZSH_COMPLETION_DIR)/_awsm

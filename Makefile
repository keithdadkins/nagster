.PHONY: install install_gcalcli install_binary

BINARY_NAME=my_binary

install: install_binary

install_gcalcli:
	@echo "Detecting OS..."
	@if [[ "$$(uname)" == "Darwin" ]]; then \
		echo "Detected macOS. Installing gcalcli using Homebrew..."; \
		brew install gcalcli; \
	elif [[ "$$(uname)" == "Linux" ]]; then \
		echo "Detected Linux. Installing gcalcli using apt-get..."; \
		sudo apt-get update && sudo apt-get install -y gcalcli; \
	else \
		echo "Unsupported OS. Please install gcalcli manually (https://github.com/insanum/gcalcli)"; \
		exit 1; \
	fi

install_binary:
	./install.sh $(BINARY_NAME)

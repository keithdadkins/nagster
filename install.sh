#!/usr/bin/env bash
BINARY_NAME=$1

if [ -z "$BINARY_NAME" ]; then
  echo "Usage: ./install.sh <binary-name>"
  exit 1
fi

# we will check for the following directories in the user's PATH 
COMMON_DIRS=("$HOME/.local/bin" "$HOME/.bin" "/usr/local/bin" "/opt/local/bin")

AVAILABLE_DIRS=()
for d in "${COMMON_DIRS[@]}"; do
  if [ -w "$d" ] && [ -d "$d" ]; then
    AVAILABLE_DIRS+=("$d")
  fi
done

# Prompt the user to select a directory from the list or provide a custom one
echo "We found the following commonly used bin directories in your PATH."
echo "Select one to use or select Other to specify a different directory:"
select d in "${AVAILABLE_DIRS[@]}" "Other" "Cancel"; do
  if [[ -n "$d" ]]; then
    [ "$d" == "Cancel" ] && exit 1
    if [ "$d" == "Other" ]; then
      while true; do
        read -rp "Enter the directory path where you want to install $BINARY_NAME: " d 
        if [ -d "$d" ]; then
          echo "Directory $d already exists."
          break
        else
          read -rp "Directory $d does not exist. Do you want to create it? (y/n) " yn
          case $yn in
            [Yy]* ) mkdir -p "$d"; echo "Created directory $d"; break;;
            [Nn]* ) echo "Please provide an existing directory."; continue;;
            * ) echo "Please answer yes or no.";;
          esac
        fi
      done
    fi
    break
  else
    echo "Invalid selection. Please try again."
  fi
done

# Check if the selected directory is in PATH
if [[ ":$PATH:" != *":$d:"* ]]; then
  echo "Directory $d is not in your PATH."
  echo "To add it to your PATH, add the following line to your ~/.bashrc or ~/.zshrc file:"
  echo "export PATH=\$PATH:$d"
fi

# Install the binary
cp "$BINARY_NAME" "$d"
chmod +x "$d/$BINARY_NAME"
echo "$BINARY_NAME has been installed to $d"


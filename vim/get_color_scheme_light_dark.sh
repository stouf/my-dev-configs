#!/bin/bash

# This script is intended to work on Mac OS.
# It reads the system configuration and return "dark" is the dark mode is enabled, or "light" otherwise.

defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q -i "dark"

if [ $? -eq 0 ]; then
  echo "dark"
else
  echo "light"
fi

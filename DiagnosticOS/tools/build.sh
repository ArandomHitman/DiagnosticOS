#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
BUILD_DIR="build"
SOURCE_DIR="src"
TARGET="kernel"
KERNEL_CONFIG="configs/linux_config"

# Create build directory if it doesn't exist
mkdir -p $BUILD_DIR

# Compile source files with kernel-specific flags
echo "Compiling kernel source files..."
gcc -o $BUILD_DIR/$TARGET $SOURCE_DIR/*.c -Iinclude -D__KERNEL__ -Wall -Wextra -std=gnu99

# Print success message
echo "Kernel build successful! Executable is located at $BUILD_DIR/$TARGET"
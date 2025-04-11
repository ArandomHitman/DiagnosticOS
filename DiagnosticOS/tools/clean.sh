#!/bin/bash

# Script to clean up temporary files, logs, and kernel build artifacts

# Define directories and files to clean
TEMP_DIR="/tmp"
LOG_DIR="/var/log"
KERNEL_BUILD_DIR="build"
KERNEL_OBJ_DIR="obj"
KERNEL_BIN_DIR="bin"

# Function to clean a directory
clean_directory() {
    local DIR=$1
    echo "Cleaning directory: $DIR"
    rm -rf ${DIR}/*
}

# Clean temporary files
clean_directory $TEMP_DIR

# Clean log files
clean_directory $LOG_DIR

# Clean kernel build artifacts
echo "Cleaning kernel build artifacts..."
rm -rf $KERNEL_BUILD_DIR $KERNEL_OBJ_DIR $KERNEL_BIN_DIR

echo "Cleanup completed."
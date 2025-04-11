#!/bin/bash

# RAM Test Script
# This script performs a series of tests to check the system's RAM

# Function to check if memtester is installed
check_memtester() {
    if ! command -v memtester &> /dev/null; then
        echo "memtester could not be found. Please install it first."
        exit 1
    fi
}

# Function to perform a basic memory test
basic_memory_test() {
    echo "Performing basic memory test..."
    free -h
    echo "Basic memory test completed."
}

# Function to perform an advanced memory test using memtester
advanced_memory_test() {
    echo "Performing advanced memory test..."
    # Run memtester with 100MB of memory for 5 iterations
    sudo memtester 100M 5
    echo "Advanced memory test completed."
}

# Function to check for memory errors in system logs
check_system_logs() {
    echo "Checking system logs for memory errors..."
    dmesg | grep -i error
    echo "System log check completed."
}

# Main function
main() {
    check_memtester
    basic_memory_test
    advanced_memory_test
    check_system_logs
    echo "RAM test completed."
}

# Execute main function
main
#!/bin/bash

# DiagnosticOS Disk Test Script
# This script diagnoses the performance of storage devices (HDD, SATA SSD, NVMe SSD)
# and provides recommendations based on read/write speed.

set -euo pipefail

# Function to log messages with timestamps
log() {
    local level="$1"
    local message="$2"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$level] $message"
}

# Function to test read/write speed
test_speed() {
    local device="$1"
    log "INFO" "Testing read/write speed for device: $device"
    local result
    result=$(dd if=/dev/zero of="$device" bs=1M count=1024 conv=fdatasync 2>&1 | grep -o '[0-9.]* MB/s' || true)
    if [[ -z "$result" ]]; then
        log "ERROR" "Failed to measure speed for device: $device"
        echo "0"
    else
        echo "$result"
    fi
}

# Function to diagnose HDD
diagnose_hdd() {
    local device="$1"
    log "INFO" "Diagnosing HDD: $device"
    local speed
    speed=$(test_speed "$device")
    log "INFO" "HDD Read/Write Speed: $speed"
    echo "Read/Write Speed: $speed"
    if (( $(echo "$speed < 50" | bc -l) )); then
        echo "HDD is slow. Consider defragmenting or replacing."
        log "WARNING" "HDD is performing below optimal speed."
    else
        echo "HDD is performing well."
        log "INFO" "HDD is performing within acceptable parameters."
    fi
}

# Function to diagnose SATA SSD
diagnose_sata_ssd() {
    local device="$1"
    log "INFO" "Diagnosing SATA SSD: $device"
    local speed
    speed=$(test_speed "$device")
    log "INFO" "SATA SSD Read/Write Speed: $speed"
    echo "Read/Write Speed: $speed"
    if (( $(echo "$speed < 200" | bc -l) )); then
        echo "SATA SSD is slow. Consider checking for firmware updates or replacing."
        log "WARNING" "SATA SSD is performing below optimal speed."
    else
        echo "SATA SSD is performing well."
        log "INFO" "SATA SSD is performing within acceptable parameters."
    fi
}

# Function to diagnose NVMe SSD
diagnose_nvme_ssd() {
    local device="$1"
    log "INFO" "Diagnosing NVMe SSD: $device"
    local speed
    speed=$(test_speed "$device")
    log "INFO" "NVMe SSD Read/Write Speed: $speed"
    echo "Read/Write Speed: $speed"
    if (( $(echo "$speed < 1000" | bc -l) )); then
        echo "NVMe SSD is slow. Consider checking for firmware updates or replacing."
        log "WARNING" "NVMe SSD is performing below optimal speed."
    else
        echo "NVMe SSD is performing well."
        log "INFO" "NVMe SSD is performing within acceptable parameters."
    fi
}

# Main function to determine device type and run diagnostics
main() {
    local device="$1"

    # Validate device
    if [[ ! -b "$device" ]]; then
        log "ERROR" "Invalid device: $device. Ensure the device path is correct."
        echo "Error: Invalid device. Please provide a valid block device."
        exit 1
    fi

    log "INFO" "Starting diagnostics for device: $device"

    # Determine if the device is rotational (HDD) or non-rotational (SSD)
    local type
    type=$(lsblk -dno rota "$device")
    if [[ "$type" -eq 1 ]]; then
        diagnose_hdd "$device"
    else
        # Check for NVMe or SATA SSD
        local model
        model=$(cat "/sys/block/$(basename "$device")/device/model" 2>/dev/null || echo "")
        if [[ "$model" == *"NVMe"* ]]; then
            diagnose_nvme_ssd "$device"
        else
            diagnose_sata_ssd "$device"
        fi
    fi

    log "INFO" "Diagnostics completed for device: $device"
}

# Ensure a device is provided as an argument
if [[ $# -lt 1 ]]; then
    log "ERROR" "No device specified."
    echo "Usage: $0 <device>"
    echo "Example: $0 /dev/sda"
    exit 1
fi

# Run the main function
main "$1"
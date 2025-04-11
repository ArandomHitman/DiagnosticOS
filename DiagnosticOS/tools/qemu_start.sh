#!/bin/bash

# Script to start QEMU with predefined settings for the Linux Kernel

# Set the path to the kernel image
KERNEL_IMAGE="bzImage"

# Set the path to the initial RAM disk (optional, if required)
INITRD_IMAGE="initrd.img"

# Set the kernel command line arguments
KERNEL_CMDLINE="console=ttyS0 root=/dev/sda"

# Set the path to the disk image
DISK_IMAGE="/etc/to/your/disk/DiagnosticOS.img"

# Set the amount of memory to allocate (in MB)
MEMORY=1024

# Set the number of CPU cores to use
CPUS=2

# Start QEMU with Linux Kernel-specific options
qemu-system-x86_64 -kernel "$KERNEL_IMAGE" \
                   -initrd "$INITRD_IMAGE" \
                   -append "$KERNEL_CMDLINE" \
                   -hda "$DISK_IMAGE" \
                   -m "$MEMORY" \
                   -smp cpus="$CPUS" \
                   -nographic
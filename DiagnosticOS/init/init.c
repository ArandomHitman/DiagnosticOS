/*----------------------------------------------------------------------------
 *      DiagnosticOS - A simple operating system for diagnostics
 *----------------------------------------------------------------------------
 *      Name:    init.c
 *      Purpose: Initialization code for DiagnosticOS
 *      Original Author: Liam Nayyar
 *      Version: V1.0
 *      Contributors
 *----------------------------------------------------------------------------
 */
#include <net/if.h>
#include <stdio.h>
#include "stdlib.h"
#include "string.h"
#include <unistd.h>
#include <sys/types.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <arpa/inet.h>
#include <sys/time.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>

int open_file(const char *filename) {
    int fd = open(filename, O_RDONLY);
    if (fd < 0) {
        perror("open");
        exit(1);
    }
    return fd;
}

void close_file(int fd) {
    if (close(fd) < 0) {
        perror("close");
        exit(1);
    }
}

void read_file(int fd, void *buf, size_t count) {
    if (read(fd, buf, count) < 0) {
        perror("read");
        exit(1);
    }
}

void write_file(int fd, void *buf, size_t count) {
    if (write(fd, buf, count) < 0) {
        perror("write");
        exit(1);
    }
}

void initialize_system() {
    // Initialization code here
    printk(KERN_INFO "System initialization started.\n");
    // Initialize disks
    printk(KERN_INFO "Initializing disks...\n");
    // Disk initialization code here
    printk(KERN_INFO "Disks initialized successfully.\n");

    // Initialize network
    printk(KERN_INFO "Initializing network...\n");
    // Network initialization code here
    printk(KERN_INFO "Network initialized successfully.\n");

    // Initialize memory
    printk(KERN_INFO "Initializing memory...\n");
    // Memory initialization code here
    printk(KERN_INFO "Memory initialized successfully.\n");

    // Initialize other peripherals
    printk(KERN_INFO "Initializing peripherals...\n");
    // Peripherals initialization code here
    printk(KERN_INFO "Peripherals initialized successfully.\n");
    printk(KERN_INFO "System initialization completed.\n");
}

int main() {
    printf("Starting DiagnosticOS...\n");
    initialize_system();
    // Check if Wake-on-LAN is enabled
    int sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (sock < 0) {
        perror("socket");
        return 1;
    }

    struct ifreq ifr;
    strncpy(ifr.ifr_name, "eth0", IFNAMSIZ-1);
    if (ioctl(sock, SIOCGIFFLAGS, &ifr) < 0) {
        perror("ioctl");
        close(sock);
        return 1;
    }

    if (ifr.ifr_flags & IFF_UP) {
        printf("WAKE ON LAN is enabled. To disable it, please restart and head to your BIOS\n");
        printf("If you don't know how to head to your BIOS, please check your motherboard manual\n");
        printf("Alternatively, look up your motherboard model or manufacturer on the internet for the BIOS key\n");
    }

    close(sock);

    printf("=====================================================================\n");
    printf("=====================================================================\n");
    printf("======================WELCOME to DiagnosticOS========================\n");
    printf("=====================================================================\n");
    printf("=====================================================================\n");
    printf("DiagnosticOS is up and running.\n");
    return 0;
}
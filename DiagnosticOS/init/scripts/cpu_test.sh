    #!/bin/bash
    
    # Check for root privileges
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root" 
        exit 1
    fi

    # Function to check CPU temperature
    check_cpu_temp() {
        echo "Checking CPU temperature..."
        sensors | grep 'Core 0' | awk '{print $3}'
    }

    # Function to run a CPU stress test
    run_stress_test() {
        echo "Running CPU stress test..."
        stress --cpu 4 --timeout 60
    }

    # Function to check for CPU errors in dmesg
    check_dmesg_errors() {
        echo "Checking dmesg for CPU errors..."
        dmesg | grep -i 'error\|fail\|fault'
    }

    # Function to check for bent pins (requires visual inspection)
    check_bent_pins() {
        echo "Checking for bent pins requires visual inspection. Please power off the system and inspect the CPU socket."
        echo "Different CPU's may have different pin configurations. Some may not have pins, as they are soldered to the motherboard."
        echo "If you find bent pins, carefully straighten them using a small tool like a toothpick or a precision screwdriver."
        echo "If you are not comfortable doing this, please seek professional help from a repair shop."
    }

    # Function to check CPU usage
    check_cpu_usage() {
        echo "Checking CPU usage..."
        mpstat | grep 'all' | awk '{print $3"% user, "$5"% system, "$12"% idle"}'
    }

    # Function to check CPU frequency
    check_cpu_frequency() {
        echo "Checking CPU frequency..."
        lscpu | grep 'MHz'
    }

    # Function to display help message
    display_help() {
        echo "Usage: $0 [option]"
        echo "Options:"
        echo "  --temp          Check CPU temperature"
        echo "  --stress        Run CPU stress test"
        echo "  --dmesg         Check dmesg for CPU errors"
        echo "  --pins          Check for bent pins"
        echo "  --usage         Check CPU usage"
        echo "  --frequency     Check CPU frequency"
        echo "  --all           Run all diagnostics"
        echo "  --help          Display this help message"
    }

    # Main function
    main() {
        if [[ $# -eq 0 ]]; then
            display_help
            exit 1
        fi

        case $1 in
            --temp)
                check_cpu_temp
                ;;
            --stress)
                run_stress_test
                ;;
            --dmesg)
                check_dmesg_errors
                ;;
            --pins)
                check_bent_pins
                ;;
            --usage)
                check_cpu_usage
                ;;
            --frequency)
                check_cpu_frequency
                ;;
            --all)
                check_cpu_temp
                run_stress_test
                check_dmesg_errors
                check_bent_pins
                check_cpu_usage
                check_cpu_frequency
                ;;
            --help)
                display_help
                ;;
            *)
                echo "Invalid option: $1"
                display_help
                exit 1
                ;;
        esac

        echo "CPU diagnostics completed."
    }

    main "$@"

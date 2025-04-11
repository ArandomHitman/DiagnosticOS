#!/bin/bash

# Function to run a GPU benchmark test
run_benchmark() {
    echo "Running GPU benchmark test..."
    # Simulate a GPU benchmark test (replace with actual benchmark commands)
    local score=$((RANDOM % 10000 + 1))
    echo "Benchmark score: $score"
    echo $score
}

# Function to evaluate the score
evaluate_score() {
    local score=$1
    if [ $score -lt 2000 ]; then
        echo "Performance: Poor"
    elif [ $score -lt 4000 ]; then
        echo "Performance: Fair"
    elif [ $score -lt 6000 ]; then
        echo "Performance: Good"
    elif [ $score -lt 8000 ]; then
        echo "Performance: Excellent"
    else
        echo "Performance: Legendary"
    fi
}

# Main script execution
score=$(run_benchmark)
evaluate_score $score
#!/bin/bash

# This script demonstrates a race condition bug.

count=0

# Function to increment the counter
increment_counter() {
  local prev_count=$count
  sleep 0.1  # Simulate some work
  count=$((prev_count + 1))
}

# Create multiple processes to increment the counter simultaneously
for i in {1..10}; do
  increment_counter &
  done

wait # Wait for all background processes to finish

echo "Final count: $count"
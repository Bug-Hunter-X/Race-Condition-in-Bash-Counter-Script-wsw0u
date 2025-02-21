#!/bin/bash

# This script demonstrates a solution to the race condition bug.

count=0
lock_file="counter.lock"

# Function to increment the counter atomically
increment_counter() {
  # Acquire the lock
  flock -x "$lock_file" || exit 1

  local prev_count=$count
  sleep 0.1  # Simulate some work
  count=$((prev_count + 1))

  # Release the lock
  flock -u "$lock_file"
}

# Create multiple processes to increment the counter simultaneously
for i in {1..10}; do
  increment_counter &
  done

wait # Wait for all background processes to finish

echo "Final count: $count"
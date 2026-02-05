#!/bin/bash

# MathBases Test Runner
# Simple script to run all validation tests

set -e

echo "🧪 MathBases Test Suite"
echo "====================="

# Set up Ruby environment
export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"
export GEM_HOME=$HOME/.gem

echo "Setting up environment..."
if ! command -v bundle &> /dev/null; then
    echo "Installing bundler..."
    gem install bundler --user-install
fi

if [ ! -f "Gemfile.lock" ]; then
    echo "Installing dependencies..."
    bundle install
fi

echo
echo "Running validation tests..."
ruby test_validation.rb

echo
echo "✅ All tests completed!"
#!/usr/bin/env bash
# Exit on error
set -o errexit

# Install dependencies
bundle install

# Precompile assets with trace
bundle exec rake assets:precompile

# Clean assets with trace
bundle exec rake assets:clean

bundle exec rake db:reset



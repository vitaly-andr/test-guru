#!/usr/bin/env bash
# Exit on error
set -o errexit

# Install dependencies
bundle install

# Precompile assets with trace
bundle exec rake assets:precompile --trace

# Clean assets with trace
bundle exec rake assets:clean --trace

## Migrate the database with trace (ensure this step is included)
#bundle exec rake db:migrate --trace

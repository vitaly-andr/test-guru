#!/usr/bin/env bash
# Exit on error
set -o errexit

# Install dependencies
bundle install

# Precompile assets with trace
bundle exec rake assets:precompile

# Clean assets with trace
bundle exec rake assets:clean

# Reset database if it's the first deployment
if [ "$RAILS_ENV" == "production" ]; then
  echo "Resetting database..."
  DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rake db:reset
else
  echo "Migrating database..."
  bundle exec rake db:migrate
fi



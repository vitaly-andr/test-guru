#!/usr/bin/env bash
# Exit on error
set -o errexit

bundle install

bundle exec rake assets:precompile

bundle exec rake assets:clean

# Function to check if the database exists
function db_exists() {
  bundle exec rails db:exists
  return $? # Capture the exit status of the rake task
}

# Check if the database exists
if db_exists; then
  echo "Database exists. Running migrations..."
  bundle exec rake db:migrate
else
  echo "Database does not exist. Creating and seeding..."
  bundle exec rake db:create
  bundle exec rake db:migrate
  bundle exec rake db:seed
fi

if [ "$RAILS_ENV" = "production_local" ]; then
  echo "Starting server in ${RAILS_ENV} environment..."
  bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RAILS_ENV}
fi

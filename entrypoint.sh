#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Run database migrations
bundle exec rake db:migrate

# Reindex searchkick models
bundle exec rails searchkick:reindex:all

# # Seed the database
# bundle exec rake db:seed

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"

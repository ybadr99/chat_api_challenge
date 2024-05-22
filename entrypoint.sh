#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Run database migrations
bundle exec rake db:migrate

# Import messages into Elasticsearch
bundle exec rails runner "Message.import(force: true)"

# # Seed the database
# bundle exec rake db:seed

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"

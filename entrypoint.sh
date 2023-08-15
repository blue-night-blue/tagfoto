#!/bin/bash
set -e

rm -f tmp/pids/server.pid
mkdir -p tmp/sockets
mkdir -p tmp/pids

bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:migrate:status
bundle exec rails db:seed
bundle exec rails assets:precompile RAILS_ENV=production

exec "$@"

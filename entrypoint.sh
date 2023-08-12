#!/bin/bash
set -e
rm -f /tagfoto/tmp/pids/server.pid

bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:migrate:status
bundle exec rails db:seed
bundle exec rails assets:precompile RAILS_ENV=production

exec "$@"

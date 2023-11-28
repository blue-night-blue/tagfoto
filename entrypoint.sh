#!/bin/bash
set -e

bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:migrate:status
bundle exec rails assets:precompile

exec "$@"
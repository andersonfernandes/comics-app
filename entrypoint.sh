#! /bin/bash
set -e

rm -f /app/tmp/pids/server.pid

bundle install
yarn install

bundle exec rails db:prepare
bundle exec rails server -p 3000 -b 0.0.0.0

#! /bin/bash
set -e

bundle install
yarn install

bundle exec rails server -p 3000 -b 0.0.0.0

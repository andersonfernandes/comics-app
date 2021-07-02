ARG RUBY_VERSION=2.7.3
FROM ruby:$RUBY_VERSION
ARG DEBIAN_FRONTEND=noninteractive

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

RUN apt-get update && apt-get install -y \
      build-essential \
      nodejs \
      yarn \
      locales \
      sudo \
  && apt-get clean

ENV LANG C.UTF-8

RUN mkdir -p /app && chown $USER:$USER /app
WORKDIR /app

RUN gem install bundler

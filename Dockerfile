FROM ubuntu:latest

MAINTAINER Manuel Garcia <mgarciap@gmail.com>

# Elixir requires UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install dependencies
RUN apt-get update && apt-get install -y wget curl apt-utils

RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
    && dpkg -i erlang-solutions_1.0_all.deb \
    && apt-get update \
    # Install the Erlang/OTP platform and all of its applications:
    && apt-get -y install esl-erlang \
    # Install Elixir
    && apt-get -y install elixir \
    # Install Phoenix
    && mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez \
    && mix local.hex --force \
    && mix local.hex --force \
    && mix local.rebar --force \
    && mix hex.info \
    && apt-get install -y inotify-tools postgresql-client


# Install Node.js (>= 6.0.0) and NPM in order to satisfy brunch.io dependencies
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs

# Clean up
RUN apt-get clean && rm erlang-solutions_1.0_all.deb

WORKDIR /app
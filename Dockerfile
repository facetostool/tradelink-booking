FROM ruby:3.1.2-alpine

ENV RAILS_ENV production

RUN apk update && apk add build-base nodejs npm postgresql-dev tzdata

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install
RUN npm install --global yarn

COPY . .

CMD rm -f tmp/pids/server.pid && rails assets:precompile && bundle exec rails s -b 0.0.0.0
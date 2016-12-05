FROM ruby:2-slim

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

# for nokogiri
#RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
#RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

# for JS runtime
RUN apt-get update && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# for postgres
RUN apt-get update && apt-get install -y libpq-dev \
    && rm -rf /var/lib/apt/lists/*

RUN set -ex && buildDeps='build-essential' \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends \
    && bundle install \
    && apt-get purge -y --auto-remove $buildDeps \
    && rm -rf /var/lib/apt/lists/*

COPY . /usr/src/app

RUN RAILS_ENV=production bundle exec rails assets:precompile

EXPOSE 3000

#CMD ["rails", "server", "-b", "0.0.0.0"]
CMD ["/usr/src/app/run-tests.sh"]

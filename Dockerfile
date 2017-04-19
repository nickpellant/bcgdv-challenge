FROM ruby:2.4.1
MAINTAINER nick@nickpellant.com

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  locales

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

ENV APP_HOME /prog_image
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]

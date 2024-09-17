# Base for the image is the current version of ruby and the latest alpine image available for that version
FROM ruby:3.3.5-alpine AS base

ARG ENV="production"

################################################################################
FROM base AS build

RUN apk --no-cache add build-base

WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install --deployment --without test development

################################################################################
FROM base AS app
ENV RACK_ENV="${ENV}"

COPY ./ /app
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /app/vendor/bundle /app/vendor/bundle

WORKDIR /app

# Run and own only the runtime files as a non-root user for security
RUN adduser sinatra --disabled-password

USER sinatra:sinatra

EXPOSE 4567
CMD ["ruby", "app.rb"]

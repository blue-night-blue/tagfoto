FROM --platform=linux/x86_64 ruby:3.2.2

RUN apt-get update && apt-get install -y \
        libvips \
        imagemagick

WORKDIR /tagfoto

COPY Gemfile Gemfile.lock ./
RUN bundle
COPY . .

ENTRYPOINT ["bash", "/tagfoto/entrypoint.sh"]

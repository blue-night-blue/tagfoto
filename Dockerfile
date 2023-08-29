#Docker関係の設定は全て https://qiita.com/three_mouth_ago/items/b7c54ae1b0f831060a70 を参考

FROM --platform=linux/x86_64 ruby:3.2.2

ENV APP="/tagfoto"  \
    CONTAINER_ROOT="./" 

RUN apt-get clean && \
    rm -rf /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin && \
    apt-get update && apt-get install -y \
        libvips \
        imagemagick

WORKDIR $APP
COPY Gemfile Gemfile.lock $CONTAINER_ROOT
RUN bundle
COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

VOLUME ["/tagfoto/public"]
VOLUME ["/tagfoto/tmp"]

#railsアプリ起動コマンド
CMD ["unicorn", "-p", "3000", "-c", "/tagfoto/config/unicorn.rb", "-E", "$RAILS_ENV"]
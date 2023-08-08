#Docker関係の設定は全て https://qiita.com/three_mouth_ago/items/b7c54ae1b0f831060a70 を参考
FROM --platform=linux/x86_64 ruby:3.2.2

#環境変数
ENV APP="/tagfoto"  \
    CONTAINER_ROOT="./" 

RUN apt-get update && apt-get install -y \
        nodejs \
        mariadb-client \
        build-essential \
        wget \
        libvips \
        imagemagick \
        yarn

WORKDIR $APP
COPY Gemfile Gemfile.lock $CONTAINER_ROOT
RUN bundle install
#↓懸念点（開発環境ではCOPYをしたくないが、本番環境でする必要がある）
COPY . .

#DB関連の実行
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

#nginxコンテナからrailsコンテナの以下のファイルをマウントすることでソケット通信を可能にする
VOLUME ["/tagfoto/public"]
VOLUME ["/tagfoto/tmp"]

#railsアプリ起動コマンド
CMD ["unicorn", "-p", "3000", "-c", "/tagfoto/config/unicorn.rb", "-E", "$RAILS_ENV"]
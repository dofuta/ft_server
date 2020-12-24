# CMD: docker runするときに実行される
# RUN: docker buildするときに実行される
# FROM: 元となるイメージを取ってくる
# LABEL: 管理用に情報を記述しておく

# get image
FROM debian:buster
# 作成したユーザの情報
LABEL maintainer="tdofuku <tangfu06@gmail.com>"

# 環境変数//不要なエラーの非表示
ENV DEBIAN_FRONTEND noninteractive

RUN echo "building start..."
# install tools
RUN	set -ex; \
  # install可能なリストを更新
	apt-get update; \
  # install開始
	apt-get install -y \
  # mariadb(mysqlのコミュニティ版)
		mariadb-server mariadb-client \
  # nginx
		nginx \
  # PHP関連
		php php-mysql php-fpm php-curl php-gd \
		php-intl php-mbstring php-soap php-xml \
		php-xmlrpc php-zip \
  # vim
    vim \
  # envsubst
    gettext-base \
  # phpmyadminをwgetでインストールするためにwgetをインストール
    wget \
  # SSL証明書の作成のためのパッケージ
    openssl \
  # 無駄なサービスをインストールしない & キャッシュを消す
	--no-install-recommends && rm -r /var/lib/apt/lists/*;
  # タイムゾーンを東京に（このコマンドうまく動かない。）
  # ln -sf  /usr/share/zoneinf o/Asia/Tokyo /etc/localtime

# apt-getのcache削除（不要）
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# phpmyadmiをインストール（apt-getでインストールできないので、wgetでインストールする）
RUN wget --no-check-certificate https://files.phpmyadmin.net/phpMyAdmin/4.9.7/phpMyAdmin-4.9.7-all-languages.tar.gz; \
  tar xvf phpMyAdmin-4.9.7-all-languages.tar.gz && rm -rf phpMyAdmin-4.9.7-all-languages.tar.gz; \
  mv phpMyAdmin-4.9.7-all-languages/ /usr/share/phpmyadmin; \
  # phpMyAdminの設定
  mkdir -p /var/lib/phpmyadmin/tmp; \
  chown -R www-data:www-data /var/lib/phpmyadmin;

# 事前に準備してあるphpmyadminの設定ファイルを、指定の場所にコピー（ただし、このファイル、読まれていないっぽい）
COPY /srcs/config.inc.php /usr/share/phpmyadmin/

# mysqlでwordpressデータベーステーブルを作成する
RUN	service mysql start; \
  /usr/sbin/mysqld --user=mysql & mysql --execute="CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"

# phpmyadminの設定DBの作成
RUN service mysql start; \
  # phpmyadminテーブルの作成
  mariadb < /usr/share/phpmyadmin/sql/create_tables.sql; \
  # phpmyadmin管理ユーザーの作成
  mysql --execute="GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO 'pma'@'localhost' IDENTIFIED BY 'wordpress';"; \
  # phpmyadmin一般ユーザーの作成
  mysql --execute="GRANT ALL PRIVILEGES ON *.* TO 'wordpress'@'localhost' IDENTIFIED BY 'wordpress' WITH GRANT OPTION;"

# nginx内にphpmyadminとwordpressの設定が書かれたlocalhostファイルをコピーする
COPY /srcs/localhost.template /etc/nginx/sites-available/
COPY /srcs/localhost.template /etc/nginx/sites-available/localhost
# バーチャルホスト「localhost」の設定を通す
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost


# wordpressの設定開始
WORKDIR /tmp

# wordpressをダウンロード
RUN wget --no-check-certificate https://ja.wordpress.org/latest-ja.tar.gz; \
  tar xvf latest-ja.tar.gz && rm -rf latest-ja.tar.gz;

# 事前に用意したwordpressの設定ファイルをコピーしてくる
COPY /srcs/wp-config.php /tmp/wordpress/

# tmpディレクトリから公開ディレクトリにwordpressを移動させる
RUN mv /tmp/wordpress /var/www/html/; \
  # ファイルの所有権を `+ www-data +`ユーザーとグループに割り当てます。 これは、Nginxを実行するユーザーとグループです。
  # Nginxは、Webサイトにサービスを提供して自動更新を実行するために、WordPressファイルを読み書きできる必要があります。
  chown -R www-data:www-data /var/www/html;

# HTTPS化の設定開始
WORKDIR /etc/ssl/certs

# CAの秘密鍵（.key）と証明書(.crt)生成
RUN openssl req \
    -new \
    -newkey rsa:4096 \
    -days 3650 \
    -nodes \
    -x509 \
    -subj "/C=US/ST=FL/L=Ocala/O=Home/CN=example.com" \
    -keyout ca.key \
    -out ca.crt

# 証明書要求（.csr）を作成する
RUN openssl \
    req -nodes \
    -newkey \
    rsa:2048 \
    -keyout server.key \
    -out server.csr \
    -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=localhost";

# CAの証明書（.crt）と署名要求（.csr）を掛け合わせて、証明書ファイル（.crt）を作成する
RUN openssl \
    x509 -req \
    -days 365 \
    -CA ca.crt \
    -CAkey ca.key \
    -CAcreateserial \
    -in server.csr \
    -out server.crt;

# 80番/443番port開放
EXPOSE 80
EXPOSE 443

# start.shを実行 （複数のサービスを開始するシェルが書いてある）
COPY srcs/start.sh /start.sh
RUN chmod 744 /start.sh
CMD ["/start.sh"]

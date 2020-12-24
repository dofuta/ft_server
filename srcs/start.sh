#!/bin/bash
# envsubtを利用して、localhostファイルの中の環境変数を、環境変数の値に置き換える
$AUTOINDEX=${AUTOINDEX:-on}
/bin/sh -c "envsubst '\$AUTOINDEX' < /etc/nginx/sites-available/localhost.template > /etc/nginx/sites-available/localhost"

/usr/sbin/service nginx start       # バックグランドで起動
/usr/sbin/service mysql start       # バックグランドで起動
/usr/sbin/service php7.3-fpm start  # バックグランドで起動

# /usr/sbin/nginx -g daemon off       # nginxのデーモンをoffにして、フォアグラウンドで実行できるようにする

while true ; do
    /bin/bash    # 最後のプロセスはフォアグラウンドで起動, docker attach でコンテナ内に入るためのものです。
done

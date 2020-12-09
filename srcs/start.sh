#!/bin/bash

/usr/sbin/service nginx start       # バックグランドで起動
# /usr/sbin/nginx -g daemon off       # nginxのデーモンをoffにして、フォアグラウンドで実行できるようにする
/usr/sbin/service mysql start       # バックグランドで起動
/usr/sbin/service php7.3-fpm start  # バックグランドで起動

while true ; do
    /bin/bash    # 最後のプロセスはフォアグラウンドで起動, docker attach でコンテナ内に入るためのものです。
done

メモ 
**ft_server**

syamashi/hkamiya両氏のまとめ
https://note.com/syamashi/n/nd296e3e46dab

Dockerfile作る際の作業手順
https://qiita.com/pottava/items/452bf80e334bc1fee69a

Dockerfileの書き方
https://discordapp.com/channels/691903146909237289/731011047485341727/751237428890566707

LEMPのインストール
https://www.codeflow.site/ja/article/how-to-install-wordpress-with-lemp-nginx-mariadb-and-php-on-debian-10

phpmyadminのインストール
https://www.digitalocean.com/community/tutorials/how-to-install-phpmyadmin-from-source-debian-10

nginxの設定ファイルの書き方
https://qiita.com/morrr/items/7c97f0d2e46f7a8ec967
https://yoshinorin.net/2018/04/01/nginx-virtualhost-usingby-sitesavailable/

自己証明書の発行
https://www.shellhacks.com/create-csr-openssl-without-prompt-non-interactive/

レビュー時の作業
https://discordapp.com/channels/691903146909237289/735307877060837457/737538549066366976
https://discordapp.com/channels/691903146909237289/731011047485341727/737525072985849966

Docker操作
```
# Dockerfileからイメージの作成（-tはイメージに名前をつけておくオプション）
docker build -t 任意のイメージ名 .

# イメージからコンテナを作成/起動する（-d はバックグラウンドで起動のオプション。-pは8080ポートをホストの80ポートとつなげるの意 --rmは、コンテナを停止させた時にコンテナを自動で削除してくれる） 
docker run --rm --name 任意のコンテナ名 -p 8080:80 -p 433:433 -d イメージ名

# コンテナの中に入る
docker exec -it コンテナ名 bash

# コンテナの停止 & 削除
docker stop test-container
docker rm test-container

# コンテナを現在の状態でイメージとして保存する
docker commit コンテナ名 任意のイメージ名

# buildで実行されるのはRUN
# runで実行されるのはCMD
```

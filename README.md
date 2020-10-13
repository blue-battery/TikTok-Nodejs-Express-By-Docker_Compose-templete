# PriceGetter-prototype

![logo-wide](logo.jpg)

PD-Core樹形図。<br>
Nodejsをサーバとして、D3jsで樹形図描画、GoogleのPuppeteerでPDF出力するプロジェクトです。

---

## Installation
### インストール
```
(Internet)
$ git clone https://gitlab.develop.kikkoman-sit.com/s-it/tree-diagram.git

(AWS Internal)
$ git clone http://ip-172-31-41-68.ap-northeast-1.compute.internal/s-it/tree-diagram.git
$ 
```
##開発サーバー側
```
develop-1で

権限確認

$ groups
{user} docker

$ aws configure
AWS Access Key ID [None]: AKIATM4IVUVIIJDP7MRW
AWS Secret Access Key [None]: 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
Default region name [None]: ap-northeast-1
Default output format [None]: json

確認コマンド（エラーにならない）
$ aws s3 ls

自分の作業用リポジトリ（任意のところ）で、masterをpullし最新版に更新する
$ git checkout original/master
$ git pull origin master

最新Masterにrebase
$ git rebase master

Makefileに実行権限をつける
$ chmod +x Makefile

念のため、一回掃除
$ make clean
```
####ビルド
```
$ make pub
```
####プッシュ
```
$ make push
```
####掃除
```
$ make clean
```

##本番リリース
```
web-public2で作業
```
####自分の作業用フォルダ（任意のところ）で、ecr-pull.shを準備
####実行ファイルに権限追加
```
$ chmod +x ecr-pull.sh
```
レジストリの最新コンテナをPull(バージョン番号を指定)
```
$ ./ecr-pull.sh 0.1 1
```
####docker-compose.ymlを準備
####五行目のバージョン番号を変更
    image: "233825477968.dkr.ecr.ap-northeast-1.amazonaws.com/pricegetter:1.0-1"

##サービス起動
```
$ docker-compose up --d
```

### コンテナに入る
``````
$ docker exec -it <container id> /bin/bash
``````
##ssl-key
```
openssl genrsa 2048 > private_key.pem
openssl req -new -key private_key.pem > server.csr
openssl x509 -days 3650 -req -signkey private_key.pem < server.csr > server.crt
```
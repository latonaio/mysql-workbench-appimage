# mysql-workbench-appimage

mysql-workbench-appimage は、MySQL Workbench のディストリビューション非依存・ポータブルなパッケージです。


## 実行

### 動作環境

* x64, ARMv8 Linux 環境
* X サーバ (Wayland 環境の場合、XWayland など)


### ダウンロードと実行

[Releases](https://github.com/latonaio/mysql-workbench-appimage/releases) ページからダウンロードし、実行権限を付与して実行してください。


### 起動できないとき

環境によって、追加のライブラリが必要な場合があります。例として、Ubuntu 18.04 の場合、次のようにインストールします:

```sh
sudo apt install libpcre2-8-0
```


## ビルド

### ビルド環境
* Docker
* Docker Compose v2
* GNU Make


### AppImage のビルド

次のコマンドを利用します。Docker 環境を使用してビルドを行います。

```sh
make
```


### (オプション) インストールしての利用

インストールを行うと、デスクトップにアイコンが作成されます。

```sh
make install
```

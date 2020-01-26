# README

# Bookshelf Cleaner

## 概要
読んでいる書籍の記録はもちろん、読み終わったあと処分する書籍まで
管理し余分な書籍を持ちすぎないよう管理するアプリです。

## コンセプト
本をたくさん読みたいからこそ処分も管理したい人々へ

## バージョン
Ruby 2.6.5
Rails 5.2.4.1

## 利用方法
初めて利用される方向けにテストユーザーを用意しております。
「ログインへ」から「テストユーザーとしてログイン」をクリックして
いただくことでテスト利用が可能です。

## 機能一覧
- 書籍のCRUD機能
- ユーザー登録
- ログイン機能
- 読書中フラグ（新規・削除）
- 読書完了フラグ
- 読書完了後の自身のコメント
- 他ユーザーからのコメント、読書済み書籍のお気に入り機能
- 読書中書籍のカレンダー実装による進捗管理
- メールによる読了期限近い書籍の通知
- 読書完了フラグ細分化
- 処分予定書籍の処分予定日通知メール
- 全ユーザーの処分予定書籍一覧、メッセージ機能による書籍譲り受けの希望連絡等
- メッセージが届いたらメール通知する機能
- 自分の書籍検索機能
- ユーザー全体の書籍検索
- 管理者機能
- マイページ
- 書籍のタグ付
- GoogleBooksapiによる書籍の登録
- google api等によるOauthのログイン機能(予定)
- Rspecによる各機能のテスト実装
- CircleCI導入によるテスト、rubocopのコードチェック実施(予定)
- awsのEC2によるデプロイ、S3利用による画像情報管理のクラウド化(予定)
- carrierwave利用による書籍の画像投稿機能

## カタログ設計
https://docs.google.com/spreadsheets/d/1FxiO1FihAKIjsRw-vhQIcL8uOGJ-oz3ICu9lxOljVJY/edit?usp=sharing

## テーブル定義
https://docs.google.com/spreadsheets/d/1FxiO1FihAKIjsRw-vhQIcL8uOGJ-oz3ICu9lxOljVJY/edit?usp=sharing

## ER図
https://docs.google.com/spreadsheets/d/1n1gz3bYi3JSoaTQxoqjjWctxKcjJMbjfuQ8sEZpzTpw/edit?usp=sharing

## 画面遷移図
https://docs.google.com/spreadsheets/d/1-zrzpAww1QnUnshkKZjk5W1KEXGBbZ5HjsxpAj2UvBY/edit?usp=sharing

## 画面ワイヤーフレーム
https://docs.google.com/spreadsheets/d/1vpbeY-X3w0Qf0KAufQdF1JF0Nr1tizwA8exRgMM9NTw/edit?usp=sharing

## 使用予定Gem
* carrierwave
* mini_magick
* devise
* ransack
* rails_admin
* cancancan
* dotenv_rails
* unicorn(予定)
* capistrano(予定)
* rubocop(予定)
* kaminari
* acts-as-taggable-on
* simple_calender(予定)
* chartkick(予定)
* Annotate
* aws-fog(予定)

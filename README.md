# PRさん
ツイートのアナリティクス値をスプレッドシートに転記するスクリプトです。

![prsan1](https://user-images.githubusercontent.com/52645663/135807740-64c5bd19-bb77-4161-9427-7685392d2166.gif)

[twitter](https://github.com/sferik/twitter) gemと [google_drive](https://github.com/gimite/google-drive-ruby) gemを使っています。

## インストール
1. リポジトリをクローン
```
$ git clone https://github.com/ayaka-ramens/PRsan.git
```
2. gemをインストール
```
$ cd PRsan
$ bundle install
```
## 使い方
### 設定編
#### 1. 設定ファイルをコピー
```
$ cp .env.sample .env
$ cp spreadsheet_config_sample.json spreadsheet_config.json
```

#### 2. Twitterアカウント申請
[Twitter API](https://developer.twitter.com/en) を使用するにはTwitterアカウントを開発者として申請し
APIを使用したいアプリ登録を行う必要があります。

[How to get access to the Ads API](https://developer.twitter.com/en/docs/twitter-ads-api/getting-started)

アカウント申請、アプリ登録を行うと発行される以下の情報を `.env` に入力してください。
- TWITTER_API_KEY
- TWITTER_API_SECRET
- TWITTER_ACCESS_TOKEN
- TWITTER_ACCESS_TOKEN_SECRET

#### 3. Google Drive APIとGoogle Sheets APIの有効化
[Google API Console](https://console.cloud.google.com/apis/library) から新規プロジェクトを作成し、「Google Drive API」と「Google Sheets API」を有効化します。
続いて、「APIとサービス」>「認証情報」、「認証情報を作成」>「OAuth クライアント ID」を選択します。「アプリケーションの種類」は「デスクトップアプリ」を選択します。そして、クライアントIDとクライアントシークレットが発行されます。

２で作成した `spreadsheet_config.json` にクライアントIDとクライアントシークレットを入力してください。

#### 4. スプレットシートの準備
[サンプルスプレッドシート](https://docs.google.com/spreadsheets/d/16NRgwRGX7-u9Y1UMuUOwi3tC-MHMUGn-pV5YRwYPchs/edit?usp=sharing) を参考にスプレッドシートを作成してください。(データを取得したいツイートURLをA列(tweet_url)に貼り付けてください)

作成したシートのurl `https://docs.google.com/spreadsheets/d/XXXXXXXXXX/` を `.env` ファイルの `SPREADSHEET_URL` に入力してください。
作成したシートのurl `https://docs.google.com/spreadsheets/d/XXXXXXXXXX/` の `XXXXXXXXXX` 部分を `.env` ファイルの `SPREADSHEET_KEY` に入力してください。

#### 5. Slack設定
Slackにサインインして、 [Slack API Applications](https://api.slack.com/apps) にアクセスしてください。
アプリを作成し、アプリ名や追加したいワークスペースの設定を行ってください。
そして `Incoming Webhooks` を機能に追加し、Webhookをワークスペースに追加してください。
発行されたWebhook URLを `.env` ファイルの `SLACK_WEBHOOK_URL` に入力してください。

参照: [Incoming Webhook URL](https://api.slack.com/incoming-webhooks#posting_with_webhooks)
### 使用編
#### 1. スプレットシート加工
取得したいツイートのURLをスプレッドシートA列(tweet_url)に貼り付けます。

#### 2. コマンド実行
gemのカレンとディレクトリで
```
$ bin/console
```
を入力し、
```
$ PRsan.analysis_tweet
```
を実行してください。

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

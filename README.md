# PRさん
ツイートのアナリティクス値をスプレッドシートに転記するスクリプトです。 [twitter](https://github.com/sferik/twitter) gemと [google_drive](https://github.com/gimite/google-drive-ruby) gemを使っています。

![prsan](https://user-images.githubusercontent.com/52645663/135459151-a88188ef-4b94-41ee-809a-1ea665d7f1de.gif)

## インストール
```bash
$ gem install PRsan
```
## 使い方
### 設定編
#### 1. gemをインストール
```bash
$ bundle
```

#### 2. 設定ファイルをコピー
```bash
$ cp .env.sample .env
$ cp spreadsheet_config_sample.json spreadsheet_config.json
```

#### 3. Twitterアカウント申請
[Twitter API](https://developer.twitter.com/en) を使用するにはTwitterアカウントを開発者として申請し
APIを使用したいアプリ登録を行う必要があります。

[How to get access to the Ads API](https://developer.twitter.com/en/docs/twitter-ads-api/getting-started)

アカウント申請、アプリ登録を行うと発行される以下の情報を `.env` に入力してください。
- API_KEY
- API_SECRET
- ACCESS_TOKEN
- ACCESS_TOKEN_SECRET

#### 4. Google Drive APIとGoogle Sheets APIの有効化
[Google API Console](https://console.cloud.google.com/apis/library) から新規プロジェクトを作成し、「Google Drive API」と「Google Sheets API」を有効化します。
続いて、「APIとサービス」>「認証情報」、「認証情報を作成」>「OAuth クライアント ID」を選択します。「アプリケーションの種類」は「デスクトップアプリ」を選択します。そして、クライアントIDとクライアントシークレットが発行されます。

２で作成した `spreadsheet_config.json` にクライアントIDとクライアントシークレットを入力してください。

#### 5. スプレットシートの準備
[サンプルスプレッドシート](https://docs.google.com/spreadsheets/d/16NRgwRGX7-u9Y1UMuUOwi3tC-MHMUGn-pV5YRwYPchs/edit?usp=sharing) を参考にスプレッドシートを作成してください。

作成したシートのurl `https://docs.google.com/spreadsheets/d/XXXXXXXXXX/` の `XXXXXXXXXX` 部分を `.env` ファイルの `SPREADSHEET_KEY` に入力してください。

### 使用編
#### 1. スプレットシート加工
取得したいツイートのURLをスプレッドシートA列(tweet_url)に貼り付けます。

#### 2. コマンド実行
gemのカレンとディレクトリで
```bash
$ bin/console
```
を入力し、
```bash
$ PRsan.tweet_analysis
```
を実行してください。

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

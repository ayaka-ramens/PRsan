require 'google_drive'
require 'dotenv/load'

module PRsan
  class Spreadsheet
    attr_accessor :spreadsheet

    CONFIG_PATH = 'spreadsheet_config.json'
    TWEET_URL_COL = 1
    TWEET_ID_COL = 2
    TEXT_COL = 3
    IMPRESSION_COUNT_COL = 4
    USER_PROFILE_CLICKS_COL = 5
    RETWEET_COL = 6
    LIKE_COUNT_COL = 7
    URL_LINK_CLICKS_COL = 8
    CREATED_AT_COL = 9
    OVER_WRITE_COL = 10

    def initialize
      begin
        google_drive_session = GoogleDrive::Session.from_config(CONFIG_PATH)
      rescue Signet::AuthorizationError
        config = JSON.parse(File.read(CONFIG_PATH))
        credentials = Google::Auth::UserRefreshCredentials.new(
          client_id: config['client_id'],
          client_secret: config['client_secret'],
          scope: config['scope'],
          redirect_uri: 'urn:ietf:wg:oauth:2.0:oob'
        )

        puts 'セッションの有効期限が切れたので再度認可を行います'
        $stderr.print(format("\n1. ページを開いてアクセス許可の設定を行ってください:\n%s\n\n", credentials.authorization_uri))
        $stderr.print('2. 認可コードを貼り付けてエンターを押してください: ')
        credentials.code = $stdin.gets.chomp
        credentials.fetch_access_token!

        config_data = open(CONFIG_PATH) { |f| JSON.load(f) }
        config_data['refresh_token'] = credentials.refresh_token
        File.open(CONFIG_PATH, 'w') { |f| JSON.dump(config_data, f) }
        retry
      end
      spreadsheet = google_drive_session.spreadsheet_by_key(ENV['SPREADSHEET_KEY']).worksheets[0]
    end

    def target_tweet_ids
      tweet_ids = []
      tweet_id_reg = /^http(s*):\/\/twitter.com\/(.*)\/(status|statuses)\/(\d+)$/

      (2..spreadsheet.num_rows).each do |row|
        if spreadsheet[row, TWEET_ID_COL] == ""
          spreadsheet[row, TWEET_URL_COL] =~ tweet_id_reg
          tweet_ids << $4
          # 書き込み時にtweet_idを参照するので、tweet_id取得時に書き込んでおく
          spreadsheet[row, TWEET_ID_COL] = $4.to_i
          spreadsheet.save
        elsif spreadsheet[row, OVER_WRITE_COL] == 'TRUE' && Date.parse(spreadsheet[row, CREATED_AT_COL]) > (Date.today - 30)
          spreadsheet[row, TWEET_URL_COL] =~ tweet_id_reg
          tweet_ids << $4
        else
          # non_public_metricsは過去30日までしか取れないので、作成日が過去30日より前のものは上書き不可にする
          spreadsheet[row, OVER_WRITE_COL] = false
          spreadsheet.save
        end
      end
      tweet_ids.join(',')
    end

    def write_analysis_data(tweets_data)
      writed_count = 0
      tweets_data[:data].each do |tweet|
        (2..spreadsheet.num_rows).each do |row|
          if spreadsheet[row, TWEET_ID_COL] == tweet[:id]
            spreadsheet[row, TEXT_COL] = tweet[:text]
            spreadsheet[row, IMPRESSION_COUNT_COL] = tweet[:non_public_metrics][:impression_count]
            spreadsheet[row, USER_PROFILE_CLICKS_COL] = tweet[:non_public_metrics][:user_profile_clicks]
            spreadsheet[row, RETWEET_COL] = tweet[:public_metrics][:retweet_count]
            spreadsheet[row, LIKE_COUNT_COL] = tweet[:public_metrics][:like_count]
            spreadsheet[row, URL_LINK_CLICKS_COL] = tweet[:non_public_metrics][:url_link_clicks]
            spreadsheet[row, CREATED_AT_COL] = tweet[:created_at]
            spreadsheet[row, OVER_WRITE_COL] = true
            spreadsheet.save
            writed_count += 1
          end
        end
      end
      writed_count
    end
  end
end

require "google_drive"

module PRsan
  class Spreadsheet
    TWEET_URL_COL = 1
    TEXT_COL = 2
    IMPRESSION_COUNT_COL = 3
    USER_PROFILE_CLICKS_COL = 4
    RETWEET_COL = 5
    LIKE_COUNT_COL = 6
    URL_LINK_CLICKS_COL = 7
    CREATED_AT_COL = 8
    OVER_WRITE_COL = 9

    def initialize
      google_drive_session = GoogleDrive::Session.from_config("spreadsheet_config.json")
      # initialize(spreadsheet_key)をもらいたい
      @spreadsheet = google_drive_session.spreadsheet_by_key("1_K0LTtjcuT9zreULf0WIGPdjILADWI5D2wOGxJluGQY").worksheets[0]
    end

    def target_tweet_ids
      tweet_ids = []

      (2..@spreadsheet.num_rows).each do |row|
        if @spreadsheet[row, TEXT_COL] == ""
          @spreadsheet[row, TWEET_URL_COL] =~ /^http(s*):\/\/twitter.com\/(.*)\/(status|statuses)\/(\d+)$/
          tweet_ids << $4
        elsif @spreadsheet[row, OVER_WRITE_COL] && @spreadsheet[row, CREATED_AT_COL] > (Date.today - 30)
          @spreadsheet[row, TWEET_URL_COL] =~ /^http(s*):\/\/twitter.com\/(.*)\/(status|statuses)\/(\d+)$/
          tweet_ids << $4
        else
          # non_public_metricsは過去30日までしか取れないので、作成日が過去30日より前のものは上書き不可にする
          @spreadsheet[row, OVER_WRITE_COL] = false
          @spreadsheet.save
        end
      end
      tweet_ids.join(',')
    end

    def write_analysis_data(tweets_data)
      pp tweets_data
    end
  end
end

require 'PRsan/version'
require 'PRsan/tweet'
require 'PRsan/spreadsheet'
require 'PRsan/slack'
require 'dotenv/load'

module PRsan
  class << self
    def analysis_tweet
      unless env_has_changed?
        puts '.envファイルを編集してください'
        return
      end

      spreadsheet = Spreadsheet.new
      twitter = Tweet.new

      tweet_ids = spreadsheet.target_tweet_ids
      tweets_data = twitter.get_tweets_data(tweet_ids)
      writed_count = spreadsheet.write_analysis_data(tweets_data)
      Slack.notify(writed_count)
    end

    private

    def env_has_changed?
      initial_spreadsheet_url = 'https://docs.google.com/spreadsheets/xxxxxxxxxxx'
      initial_slack_webhook_url= 'https://hooks.slack.com/services/xxxxxxxxxxx'

      return false if ENV['SPREADSHEET_URL'] == initial_spreadsheet_url || ENV['SLACK_WEBHOOK_URL'] == initial_slack_webhook_url

      keys = ['TWITTER_API_KEY', 'TWITTER_API_SECRET', 'TWITTER_ACCESS_TOKEN', 'TWITTER_ACCESS_TOKEN_SECRET', 'SPREADSHEET_KEY']
      keys.each do |k|
        return false if ENV[k] == 'xxxxxxxxxxx'
      end
    end
  end

  class Error < StandardError; end
  # Your code goes here...
end

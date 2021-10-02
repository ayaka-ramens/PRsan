require 'PRsan/version'
require 'PRsan/tweet'
require 'PRsan/spreadsheet'
require 'PRsan/slack'

module PRsan
  def self.analysis_tweet
    spreadsheet = Spreadsheet.new
    twitter = Tweet.new

    tweet_ids = spreadsheet.target_tweet_ids
    tweets_data = twitter.get_tweets_data(tweet_ids)
    writed_count = spreadsheet.write_analysis_data(tweets_data)
    Slack.notify(writed_count)
  end

  class Error < StandardError; end
  # Your code goes here...
end

require 'PRsan/version'
require 'PRsan/tweet'
require 'PRsan/spreadsheet'

module PRsan
  def self.tweet_analysis
    spreadsheet = Spreadsheet.new
    twitter = Tweet.new

    tweet_ids = spreadsheet.target_tweet_ids
    tweets_data = twitter.get_tweets_data(tweet_ids)
    spreadsheet.write_analysis_data(tweets_data)
  end

  class Error < StandardError; end
  # Your code goes here...
end

require 'twitter'
require 'dotenv/load'

module PRsan
  class Tweet
    def initialize
      @twitter_client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_API_KEY']
        config.consumer_secret     = ENV['TWITTER_API_SECRET']
        config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      end
    end

    def get_tweets_data(tweet_ids)
      url = "https://api.twitter.com/2/tweets?ids=#{tweet_ids}&tweet.fields=created_at,public_metrics,non_public_metrics"
      # TODO: エラーハンドリング
      response = Twitter::REST::Request.new(@twitter_client, :get, url).perform
    end
  end
end

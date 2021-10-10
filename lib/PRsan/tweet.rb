require 'twitter'
require 'dotenv/load'

module PRsan
  class Tweet
    def initialize
      @twitter_client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['API_KEY']
        config.consumer_secret     = ENV['API_SECRET']
        config.access_token        = ENV['ACCESS_TOKEN']
        config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
      end
    end

    def get_tweets_data(tweet_ids)
      url = "https://api.twitter.com/2/tweets?ids=#{tweet_ids}&tweet.fields=created_at,public_metrics,non_public_metrics"
      begin
        response = Twitter::REST::Request.new(@twitter_client, :get, url).perform
      rescue Twitter::Error => error
        puts "エラーが発生しました。#{error.class} #{error.message}"
      end
    end
  end
end

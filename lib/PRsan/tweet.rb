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
      # TODO: エラーハンドリング
      response = Twitter::REST::Request.new(@twitter_client, :get, url).perform
    end

    def like_count(data)
      # response[:data][0].dig(:public_metrics, :like_count)という感じで配列から取り出す必要があるが
      # 配列の中身だけ引数で受け取ることで
      # data..dig(:public_metrics, :like_count) みたいにならないかなそれならいちいちメソッドいらんかも
    end

    def user_profile_clicks
    end

    def impression_count
    end

    def url_link_clicks
    end
  end
end

require 'dotenv/load'

module PRsan
  class Slack
    def self.notify(writed_count)
      # TODO: スプレッドシートのフラグによって、該当のツイートの数値もslack通知できるようにしたい。
      message = "#{writed_count}件の書き込みをしたよ！チェックしてね #{ENV['SPREADSHEET_URL']}"
      uri = URI.parse(ENV['SLACK_WEBHOOK_URL'])
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.ssl_version = :TLSv1_2
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      req = Net::HTTP::Post.new(uri.request_uri)
      req.set_form_data(payload: {text: message}.to_json)
      http.request(req)
    end
  end
end

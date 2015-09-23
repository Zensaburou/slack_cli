require 'slack-ruby-client'

class RealTimeInterface
  def initialize
    Slack.configure do |config|
      config.token = ENV['SLACK_API_TOKEN']
    end

    @client = Slack::RealTime::Client.new
  end

  def listen
    message_handler
    @client.start!
  end

  private

  def message_handler
    @client.on :message do |data|
      parse_message(data) if data['text']
    end
  end

  def parse_message(data)
    puts(data['channel'] + ' | ' + data['user'] + ' | ' + data['text'])
  end
end

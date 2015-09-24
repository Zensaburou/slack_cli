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
      MessageHandler.new.parse_message(data)
    end
  end
end

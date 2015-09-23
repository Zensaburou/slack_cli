require 'slack-ruby-client'

class WebInterface
  def initialize
    Slack.configure do |config|
      config.token = ENV['SLACK_API_TOKEN']
    end

    @client = Slack::Web::Client.new
  end

  def message_poster_init
    user_input = nil

    until user_input == 'exit'
      user_input = gets.chomp
      post_message(user_input)
    end
  end

  private

  def post_message(user_input)
    channel_name, message = parse_input(user_input)
    channel_id = find_channel_id_by_name(channel_name)
    create_message(channel_id, message)
  end

  def parse_input(user_input)
    user_input.split('|')
  end

  def find_channel_id_by_name(channel_name)
    channel = available_channels.detect { |c| c['name'] == channel_name }
    channel['id']
  end

  def available_channels
    @client.channels_list['channels']
  end

  def create_message(channel_id, message)
    @client.chat_postMessage(
      channel: channel_id,
      text: message,
      as_user: true
    )
  end
end

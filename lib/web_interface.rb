require 'slack-ruby-client'

class WebInterface
  def initialize
    Slack.configure do |config|
      config.token = ENV['SLACK_API_TOKEN']
    end

    @client = Slack::Web::Client.new
  end

  def post_message_to_channel_by_name(channel_name, message)
    channel_id = find_channel_id_by_name(channel_name)
    post_message(channel_id, message)
  end

  def post_message(channel_id, message)
    @client.chat_postMessage(
      channel: channel_id,
      text: message,
      as_user: true
    )
  end

  def find_channel_id_by_name(channel_name)
    channel = available_channels.detect { |c| c['name'] == channel_name }
    channel['id']
  end

  def available_channels
    @client.channels_list['channels']
  end
end

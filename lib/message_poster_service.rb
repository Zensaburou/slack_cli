class MessagePosterService
  def initialize
    user_input = nil

    until user_input == 'exit'
      user_input = gets.chomp
      post_message(user_input)
    end
  end

  private

  def post_message(user_input)
    channel_name, message = parse_input(user_input)
    WebInterface.new.post_message_to_channel_by_name(channel_name, message)
  end

  def parse_input(user_input)
    user_input.split('|')
  end
end

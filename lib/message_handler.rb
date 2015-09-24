class MessageHandler
  def parse_message(message_hash)
    @message_hash = message_hash
    puts formatted_output if message_body
  end

  def formatted_output
    channel + ' | ' + user + ' | ' + message_body
  end

  def channel
    channel_id = @message_hash['channel']
    WebInterface.new.find_channel_name(channel_id)
  end

  def user
    user_id = @message_hash['user']
    WebInterface.new.find_user_name(user_id)
  end

  def message_body
    @message_hash['text']
  end
end

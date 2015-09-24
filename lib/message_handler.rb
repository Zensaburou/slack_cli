class MessageHandler
  def parse_message(message_hash)
    @message_hash = message_hash
    puts formatted_output if message_body
  end

  def formatted_output
    channel + ' | ' + user + ' | ' + text
  end

  def channel
    @message_hash['channel']
  end

  def user
    @message_hash['user']
  end

  def message_body
    @message_hash['text']
  end
end

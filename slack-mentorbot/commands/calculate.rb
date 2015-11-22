module SlackMentorbot
  module Commands
    class Calculate < SlackRubyBot::Commands::Base
      command 'calculate' do |client, data, _match|
        send_message client, data.channel, '4'
      end

      command 'insult' do |client, data, _match|
        
        send_message client, data.channel, 'Screw you, hippy!'
      end
    end
  end
end
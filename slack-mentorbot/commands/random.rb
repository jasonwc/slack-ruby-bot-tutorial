module SlackMentorbot
  module Commands
    class Random < SlackRubyBot::Commands::Base
      command 'insult' do |client, data, _match|
        send_message client, data.channel, 'Screw you, hippy!'
      end
    end
  end
end
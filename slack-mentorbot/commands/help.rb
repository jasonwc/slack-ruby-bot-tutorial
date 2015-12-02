module SlackMentorbot
  module Commands
    class Help < SlackRubyBot::Commands::Base
      command 'help' do |client, data, _match|
        menu = "Here are the list of available commands \n \
                --------------------------------------- \n \
                help \n \
                whoami \n \
                mentors \n \
                signup as mentor \n \
                remove as mentor \n \
                students \n \
                signup as student \n \
                remove as student"
        send_message client, data.channel, menu
      end
      command 'whoami' do |client, data, _match|
        response = HTTParty.get('http://localhost:3000/' + data.user)
        if response['mentor'] == true && response['student'] == true
          send_message client, data.channel, 'You are a mentor and student'
        elsif response['mentor'] == true
          send_message client, data.channel, 'You are a mentor'
        elsif response['student'] == true
          send_message client, data.channel, 'You are a student'
        else
          send_message client, data.channel, 'You are neither a mentor or student'
        end
      end
    end
  end
end
module SlackMentorbot
  module Commands
    class Calculate < SlackRubyBot::Commands::Base
      command 'calculate' do |client, data, _match|
        send_message client, data.channel, '4'
      end

      command 'insult' do |client, data, _match|
        send_message client, data.channel, 'Screw you, hippy!'
      end

      command 'mentors' do |client, data, _match|
        response = HTTParty.get('http://localhost:3000/mentors.json')
        mentors = response.parsed_response

        send_message client, data.channel, "Here are the list of mentors: "
        mentors.each do |mentor|
          send_message client, data.channel, "#{mentor['name']}"
        end
      end
    end
  end
end
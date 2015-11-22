module SlackMentorbot
  module Commands
    class Mentors < SlackRubyBot::Commands::Base
      command 'list mentors' do |client, data, _match|
        response = HTTParty.get('http://localhost:3000/mentors.json')
        mentors = response.parsed_response

        send_message client, data.channel, "Here is the list of mentors: "
        mentors.each do |mentor|
          send_message client, data.channel, "#{mentor['name']}"
        end
      end
    end
  end
end
module SlackMentorbot
  module Commands
    class Students < SlackRubyBot::Commands::Base
      command 'list students' do |client, data, _match|
        response = HTTParty.get('http://localhost:3000/students.json')
        students = response.parsed_response

        send_message client, data.channel, "Here is the list of students: "
        students.each do |student|
          send_message client, data.channel, "#{student['name']}"
        end
      end
    end
  end
end
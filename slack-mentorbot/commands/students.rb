module SlackMentorbot
  module Commands
    class Students < SlackRubyBot::Commands::Base
      command 'students' do |client, data, _match|
        response = HTTParty.get('http://localhost:3000/students.json')
        students = response.parsed_response

        send_message client, data.channel, "Here is the list of students: "
        students.each do |student|
          send_message client, data.channel, "#{student['name']}"
        end
      end

      command 'signup as student' do |client, data, _match|
        user_info = client.web_client.users_info(token: ENV['SLACK_API_TOKEN'], user: data.user)
        user_params = {
          name: user_info['user']['name'],
          slack_id: data.user
        }
        response = HTTParty.post('http://localhost:3000/students.json', query: { student: user_params })

        if response['id'].present?
          send_message client, data.channel, "Signed you up, <@#{data.user}>!"
        else
          send_message client, data.channel, "You're already signed up, <@#{data.user}>!"
        end
      end
    end
  end
end
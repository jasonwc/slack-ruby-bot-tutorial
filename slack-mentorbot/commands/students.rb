module SlackMentorbot
  module Commands
    class Students < SlackRubyBot::Commands::Base
      command 'students' do |client, data, _match|
        response = HTTParty.get('http://localhost:3000/students.json')
        if response.empty?
          send_message client, data.channel, "There currently zero students"
        else
          students = response.parsed_response
          send_message client, data.channel, "Here is the list of students: \n #{students.map{|s| s['name']}.join("\n")}"
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

      command 'remove as student' do |client, data, _match|
        response = HTTParty.delete('http://localhost:3000/students/' + data.user)
        if response['delete'] == true
          send_message client, data.channel, "You have been removed as a student"
        else
          send_message client, data.channel, "You were not a student"
        end
      end
    end
  end
end
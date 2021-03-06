module SlackMentorbot
  module Commands
    class Mentors < SlackRubyBot::Commands::Base
      command 'mentors' do |client, data, _match|
        response = HTTParty.get('http://localhost:3000/mentors.json')
        if response.empty?
          send_message client, data.channel, "There are currently zero mentors"
        else
          mentors = response.parsed_response
          send_message client, data.channel, "Here is the list of mentors: \n #{mentors.map{|m| m['name']}.join("\n")}"
        end
      end

      command 'signup as mentor' do |client, data, _match|
        user_info = client.web_client.users_info(token: ENV['SLACK_API_TOKEN'], user: data.user)
        user_params = {
          name: user_info['user']['name'],
          slack_id: data.user
        }
        response = HTTParty.post('http://localhost:3000/mentors.json', query: { mentor: user_params })

        if response['id'].present?
          send_message client, data.channel, "Signed you up, <@#{data.user}>!"
        else
          send_message client, data.channel, "You're already signed up, <@#{data.user}>!"
        end
      end

      command 'remove as mentor' do |client, data, _match|
        response = HTTParty.delete('http://localhost:3000/mentors/' + data.user)
        if response['delete'] == true
          send_message client, data.channel, "You have been removed as a mentor"
        else
          send_message client, data.channel, "You were not a mentor"
        end
      end
    end
  end
end
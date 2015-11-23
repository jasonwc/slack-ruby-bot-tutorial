module SlackMentorbot
  module Commands
    class Mentors < SlackRubyBot::Commands::Base
      command 'mentors' do |client, data, _match|
        response = HTTParty.get('http://localhost:3000/mentors.json')
        mentors = response.parsed_response

        send_message client, data.channel, "Here is the list of mentors: "
        mentors.each do |mentor|
          send_message client, data.channel, "#{mentor['name']}"
        end
      end
      command 'signup as mentor' do |client, data, _match|
        user_info = client.web_client.users_info(token: ENV['SLACK_API_TOKEN'], user: data.user)
        user_params = {
          name: user_info['user']['name'],
          slack_id: data.user
        }
        HTTParty.post('http://localhost:3000/mentors', query: { mentor: user_params })
        send_message client, data.channel, "Saved mentor into api"
      end
    end
  end
end
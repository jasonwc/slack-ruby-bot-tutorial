class SlackBotTesting < SlackRubyBot::Commands::Base
  match /^How is the weather in (?<location>\w*)\?$/ do |client, data, match|
    send_message client, data.channel, "The weather in #{match[:location]} is nice."
  end

  match /^<@U0F1M97BM> mentor from (?<start_time>(0|1)?[0-9]:[0-5][0-9]\s(a|p)m) to (?<end_time>(0|1)?[0-9]:[0-5][0-9]\s(a|p)m)$/ do |client, data, match|
    start_time = match[:start_time]
    end_time = match[:end_time]
    response = HTTParty.get('http://localhost:3000/' + data.user)
    if response['mentor'] == true
      appointment_params = {
          mentor_slack_id: data.user,
          start_time: start_time,
          end_time: end_time
      }
      response = HTTParty.post('http://localhost:3000/appointments', query: { appointment: appointment_params })
      send_message client, data.channel, "<@#{data.user}> is now mentoring from #{response["start_time"]} to #{response["end_time"]} today."
    else
      send_message client, data.channel, "You must be a mentor before creating an appointment"
    end
  end
end
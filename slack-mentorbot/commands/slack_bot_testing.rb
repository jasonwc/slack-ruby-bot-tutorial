class SlackBotTesting < SlackRubyBot::Commands::Base
  match /^How is the weather in (?<location>\w*)\?$/ do |client, data, match|
    send_message client, data.channel, "The weather in #{match[:location]} is nice."
  end
end
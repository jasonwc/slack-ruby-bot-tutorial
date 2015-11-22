require 'spec_helper'

describe SlackMentorbot::Commands::Mentors do
  def app
    SlackMentorbot::App.new
  end
  it 'sample test' do
    # expect(message: "#{SlackRubyBot.config.user} calculate 2+2", channel: 'channel').to respond_with_slack_message('4')
  end
end
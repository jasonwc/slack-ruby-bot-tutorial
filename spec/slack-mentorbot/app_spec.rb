require 'spec_helper'

describe SlackMentorbot::App do
  def app
    SlackMentorbot::App.new
  end
  it_behaves_like 'a slack ruby bot'
end
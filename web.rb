require 'sinatra/base'

module SlackMentorbot
  class Web < Sinatra::Base
    get '/' do
      'Math is good for you.'
    end
  end
end
require 'sinatra/base'

module SlackMentorbot
  class Web < Sinatra::Base
    get '/' do
      'Mentoring is soooooo fun!'
    end
  end
end
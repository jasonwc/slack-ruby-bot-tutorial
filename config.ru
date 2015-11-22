$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'slack-mentorbot'
require 'web'

Thread.new do
  begin
    SlackMentorbot::App.instance.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run SlackMentorbot::Web
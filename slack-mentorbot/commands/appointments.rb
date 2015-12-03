module SlackMentorbot
  module Commands
    class Appointments < SlackRubyBot::Commands::Base
      command 'list appointments' do |client, data, _match|
        response = HTTParty.get('http://localhost:3000/appointments.json')
        appointments = response.parsed_response

        send_message client, data.channel, "Here is the list of appointments: "
        appointments.each do |appointment|
          student = HTTParty.get("http://localhost:3000/students/#{appointment["student_id"]}.json")
          mentor = HTTParty.get("http://localhost:3000/mentors/#{appointment["mentor_id"]}.json")
          
          send_message client, data.channel, "#{student['name']} is meeting with #{mentor['name']} from #{appointment['start_time']} to #{appointment['end_time']} on #{appointment['appointment_date']}"
        end
      end

      command 'appointments' do |client, data, _match|
        response = HTTParty.get('http://localhost:3000/appointments.json')
        if response.empty?
          send_message client, data.channel, "There are currently zero appointments today"
        else
          string = String.new
          response.each do |appointment|
            if appointment['student'] == false
              str = "<@#{appointment['mentor']}> is available at #{appointment['start_time']} til #{appointment['end_time']} \n"
              string.concat(str)
            else
              str = "<@#{appointment['mentor']}> is mentoring <@#{appointment['student']}> from #{appointment['start_time']} to #{appointment['end_time']} \n"
              string.concat(str)
            end
          end
          send_message client, data.channel, string
        end
      end
    end
  end
end
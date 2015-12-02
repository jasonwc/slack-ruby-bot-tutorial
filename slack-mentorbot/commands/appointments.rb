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

      command 'sign up for appointment' do |client, data, _match|
        # determine if they are a student or mentor
        # create or update an appointment
      end
    end
  end
end
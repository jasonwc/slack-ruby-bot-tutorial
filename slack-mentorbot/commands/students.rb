module SlackMentorbot
  module Commands
    class Students < SlackRubyBot::Commands::Base
      command 'students' do |client, data, _match|
        response = HTTParty.get('http://localhost:3000/students.json')
        if response.empty?
          send_message client, data.channel, "There currently zero students"
        else
          students = response.parsed_response
          send_message client, data.channel, "Here is the list of students: \n #{students.map{|s| s['name']}.join("\n")}"
        end
      end

      command 'signup as student' do |client, data, _match|
        user_info = client.web_client.users_info(token: ENV['SLACK_API_TOKEN'], user: data.user)
        user_params = {
          name: user_info['user']['name'],
          slack_id: data.user
        }
        response = HTTParty.post('http://localhost:3000/students.json', query: { student: user_params })

        if response['id'].present?
          send_message client, data.channel, "Signed you up, <@#{data.user}>!"
        else
          send_message client, data.channel, "You're already signed up, <@#{data.user}>!"
        end
      end

      command 'remove as student' do |client, data, _match|
        response = HTTParty.delete('http://localhost:3000/students/' + data.user)
        if response['delete'] == true
          send_message client, data.channel, "You have been removed as a student"
        else
          send_message client, data.channel, "You were not a student"
        end
      end

      command 'student signup for' do |client, data, _match|
        # check to see if they are a student
        is_student = HTTParty.get('http://localhost:3000/' + data.user)
        if is_student['student'] == true
          # get appointments
          appointments = HTTParty.get('http://localhost:3000/appointments.json')
          # find the appointment id to update
          appointment_id = nil
          appointments.each do |appointment|
            # find the correct appointment id
            if _match[:expression].include? appointment['mentor']
              appointment_id = appointment['id'].to_s
              break
            end
          end
          # if there no mentor with the slack_id
          if appointment_id.nil?
            send_message client, data.channel, "#{_match[:expression]} is not a mentoring"
          else
            # update the appointment with student id
            param = {student_slack_id: data.user}
            response = HTTParty.put('http://localhost:3000/appointments/' + appointment_id + '.json', query: param)
            send_message client, data.channel, "<@#{data.user}> now have an appointment with <@#{response['mentor']}> today from #{response['start_time']} to #{response['end_time']}"
          end
        else
          send_message client, data.channel, "You must be a student to signup for a mentor"
        end
      end
    end
  end
end
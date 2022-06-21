# frozen_string_literal: true

require 'booked_session'
require 'new_session_time'

class SessionMapper
  def self.call(old_sessions, new_session_times)
    booked_sessions = old_sessions.select { |s| s[:state] == 'booked' }

    return [] if booked_sessions.empty?

    @booked_sessions = booked_sessions.map { |s| BookedSession.new(s) }
    @new_session_times = new_session_times.map { |t| NewSessionTime.new(t) }

    @new_bookings = {}

    @booked_sessions.each do |booked_session|
      @new_session_times.each do |new_session|
        if !(booked_session.hour == 15) && (new_session.state == 'booked' && booked_session.hour == new_session.hour)
          booked_session.hour += 1
          next
        end

        next unless booked_session.hour == new_session.hour

        new_session = @new_session_times.reverse.find { |ns| ns.state == 'available' } if new_session.state == 'booked'

        new_session.state = 'booked'

        @new_bookings.merge!({ booked_session.input => new_session.input })
      end
    end

    @new_bookings
  end
end

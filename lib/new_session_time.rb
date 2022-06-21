# frozen_string_literal: true

require 'time'

class NewSessionTime
  attr_accessor :state, :hour
  attr_reader :input

  def initialize(session)
    @input = session
    @hour = Time.parse(session[:starts_at]).hour
    @state = 'available'
  end
end

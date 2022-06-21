# frozen_string_literal: true

require 'time'

class BookedSession
  attr_accessor :hour
  attr_reader :input, :state

  def initialize(session)
    @input = session
    @hour = Time.parse(session[:starts_at]).hour
    @state = session[:state]
  end
end

# frozen_string_literal: true

require 'booked_session'

describe BookedSession do
  subject { described_class.new(session) }

  let(:session) { { starts_at: starts_at } }
  let(:starts_at) { '2021-06-23T13:30:00Z' }
  let(:hour) { 13 }

  describe '#initialize' do
    it 'creates a new object with a base hour attribute' do
      expect(subject.hour).to eq(hour)
    end
  end
end

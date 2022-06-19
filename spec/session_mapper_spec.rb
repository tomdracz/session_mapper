# frozen_string_literal: true

require 'session_mapper'

describe SessionMapper do
  subject { described_class.call }

  describe '#call' do
    it 'is set up correctly' do
      expect(subject).to eq(1)
    end
  end
end

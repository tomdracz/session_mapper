# frozen_string_literal: true

require 'formatter'

describe Formatter do
  subject { described_class }

  describe '#test' do
    it 'works' do
      expect(subject.test).to eq(2)
    end
  end
end

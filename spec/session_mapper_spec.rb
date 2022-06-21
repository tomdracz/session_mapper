# frozen_string_literal: true

require 'session_mapper'

describe SessionMapper do
  subject { described_class.call(old_sessions, new_times) }

  let(:old_sessions) do
    [
      {
        starts_at: '2021-06-23T09:00:00Z',
        ends_at: '2021-06-23T09:45:00Z',
        state: 'booked'
      },
      {
        starts_at: '2021-06-23T09:45:00Z',
        ends_at: '2021-06-23T10:30:00Z',
        state: 'booked'
      },
      {
        starts_at: '2021-06-23T10:30:00Z',
        ends_at: '2021-06-23T11:15:00Z',
        state: 'suspended'
      },
      {
        starts_at: '2021-06-23T11:15:00Z',
        ends_at: '2021-06-23T12:00:00Z',
        state: 'booked'
      },
      {
        starts_at: '2021-06-23T13:30:00Z',
        ends_at: '2021-06-23T14:15:00Z',
        state: 'available'
      },
      {
        starts_at: '2021-06-23T14:15:00Z',
        ends_at: '2021-06-23T15:00:00Z',
        state: 'suspended'
      },
      {
        starts_at: '2021-06-23T15:00:00Z',
        ends_at: '2021-06-23T15:45:00Z',
        state: 'booked'
      },
      {
        starts_at: '2021-06-23T15:45:00Z',
        ends_at: '2021-06-23T16:30:00Z',
        state: 'booked'
      }
    ]
  end

  let(:new_times) do
    [
      {
        starts_at: '2021-06-23T09:00:00Z',
        ends_at: '2021-06-23T09:50:00Z'
      },
      {
        starts_at: '2021-06-23T10:00:00Z',
        ends_at: '2021-06-23T10:50:00Z'
      },
      {
        starts_at: '2021-06-23T11:00:00Z',
        ends_at: '2021-06-23T11:50:00Z'
      },
      {
        starts_at: '2021-06-23T13:00:00Z',
        ends_at: '2021-06-23T13:50:00Z'
      },
      {
        starts_at: '2021-06-23T14:00:00Z',
        ends_at: '2021-06-23T14:50:00Z'
      },
      {
        starts_at: '2021-06-23T15:00:00Z',
        ends_at: '2021-06-23T15:50:00Z'
      }
    ]
  end

  describe '#call' do
    context 'with no bookings to map' do
      let(:old_sessions) { [available_session, suspended_session] }

      let(:available_session) { { state: 'available' } }
      let(:suspended_session) { { state: 'suspended' } }

      it 'returns an empty array' do
        expect(subject).to eq([])
      end
    end

    context 'with bookings to map' do
      let(:new_bookings) do
        {
          {
            starts_at: '2021-06-23T09:00:00Z',
            ends_at: '2021-06-23T09:45:00Z',
            state: 'booked'
          } => {
            starts_at: '2021-06-23T09:00:00Z',
            ends_at: '2021-06-23T09:50:00Z'
          },
          {
            starts_at: '2021-06-23T09:45:00Z',
            ends_at: '2021-06-23T10:30:00Z',
            state: 'booked'
          } => {
            starts_at: '2021-06-23T10:00:00Z',
            ends_at: '2021-06-23T10:50:00Z'
          },
          {
            starts_at: '2021-06-23T11:15:00Z',
            ends_at: '2021-06-23T12:00:00Z',
            state: 'booked'
          } => {
            starts_at: '2021-06-23T11:00:00Z',
            ends_at: '2021-06-23T11:50:00Z'
          },
          {
            starts_at: '2021-06-23T15:00:00Z',
            ends_at: '2021-06-23T15:45:00Z',
            state: 'booked'
          } => {
            starts_at: '2021-06-23T15:00:00Z',
            ends_at: '2021-06-23T15:50:00Z'
          },
          {
            starts_at: '2021-06-23T15:45:00Z',
            ends_at: '2021-06-23T16:30:00Z',
            state: 'booked'
          } => {
            starts_at: '2021-06-23T14:00:00Z',
            ends_at: '2021-06-23T14:50:00Z'
          }
        }
      end

      it 'correctly maps old bookings to the new sessions' do
        expect(subject).to eq(new_bookings)
      end
    end
  end
end

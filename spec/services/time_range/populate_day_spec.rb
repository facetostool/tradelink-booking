require 'rails_helper'

RSpec.describe TimeRange::PopulateDay, type: :service do
  subject { described_class }

  let(:freeze_time) { Time.utc(2022, 1, 1, 0, 0, 0) }

  describe '#call!' do
    around do |example|
      Timecop.freeze(freeze_time) do
        example.run
      end
    end

    it 'create 96 time ranges with a right format' do
      expect {
        subject.call!(Date.today)
      }.to change{ TimeRange.count }.from(0).to(96)

      today = Date.today
      today_dt = today.to_datetime
      tomorrow_dt = Date.tomorrow.to_datetime

      expect(TimeRange.first).to have_attributes(
        booking_id: nil,
        date: today,
        start_time: today_dt,
        end_time: today_dt + 15.minutes,
      )

      expect(TimeRange.second).to have_attributes(
        booking_id: nil,
        date: today,
        start_time: today_dt + 15.minutes,
        end_time: today_dt + 30.minutes,
      )

      expect(TimeRange.last).to have_attributes(
        booking_id: nil,
        date: today,
        start_time: tomorrow_dt - 15.minutes,
        end_time: tomorrow_dt,
      )
    end
  end
end
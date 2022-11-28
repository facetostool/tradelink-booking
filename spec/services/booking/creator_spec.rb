require 'rails_helper'

RSpec.describe Booking::Creator, type: :service do
  subject { described_class }

  describe '#ranges_free?' do
    context 'when one range is not free' do
      it 'returns false' do
        ranges = []
        ranges << build(:time_range, booking_id: nil)
        ranges << build(:time_range, booking_id: 1)
        expect(subject.ranges_free?(ranges)).to be_falsey
      end
    end

    context 'when all ranges are free' do
      it 'returns true' do
        ranges = []
        ranges << build(:time_range, booking_id: nil)
        ranges << build(:time_range, booking_id: nil)
        expect(subject.ranges_free?(ranges)).to be_truthy
      end
    end
  end

  describe '#call' do
    context 'when some of time ranges are not free' do
      let(:booking) { create(:booking) }
      let(:free_range) { create(:time_range) }
      let(:booked_range) { create(:time_range, booking: booking) }

      it 'raises error' do
        expect {
          subject.call!(time_range_ids: [free_range.id, booked_range.id])
        }.to raise_error(Booking::Creator::NotAvailableRangeError)
      end
    end

    context 'when all time ranges are free' do
      let(:free_range) { create(:time_range) }
      let(:params) {{ time_range_ids: [free_range.id], username: 'test' }}

      context 'when for some reason we could not update a time range' do
        before { allow_any_instance_of(TimeRange).to receive(:update!).and_raise(StandardError) }

        it 'rollbacks transaction' do
          expect {
            subject.call!(params)
          }.to raise_error(StandardError)

          expect(Booking.all).to be_empty
        end
      end

      context 'when everything goes well' do
        it 'creates booking and updates time_range' do
          booking = subject.call!(params)

          expect(booking.reload).to have_attributes(
            username: 'test'
          )
          expect(free_range.reload).to have_attributes(
            booking_id: booking.id
          )
        end

        context 'with parallel operation' do
          it 'still creates only single booking thanks to advisory lock' do
            threads = []
            rand(1..5).times do
              threads << Thread.new do
                begin
                  subject.call!(params)
                rescue => e
                end
              end
            end

            threads.each(&:join)

            expect(Booking.count).to eq(1)
          end
        end
      end
    end
  end
end
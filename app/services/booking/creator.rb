class Booking
  class Creator
    LOCK_NAME = 'create-booking'.freeze

    class << self
      def call!(params)
        booking = nil
        Booking.with_advisory_lock(LOCK_NAME) do
          Booking.transaction do
            time_ranges = TimeRange.find(params[:time_range_ids])
            raise NotAvailableRangeError, 'some of time ranges are already booked' unless ranges_free?(time_ranges)

            booking = Booking.create!(
              username: params[:username]
            )
            time_ranges.each { |range| range.update!(booking: booking) }
          end
        end
        booking
      end

      def ranges_free?(ranges)
        ranges.all? { |range| range.free? }
      end
    end

    class NotAvailableRangeError < StandardError; end
  end
end
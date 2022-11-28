class Api::V1::BookingsController < Api::V1::BaseController
  def index
    render json: Api::V1::BookingSerializer.new(Booking.all)
  end

  def create
    booking = Booking::Creator.call!(create_params)

    data = Api::V1::BookingSerializer.new(booking, include: [:time_ranges])
    ActionCable.server.broadcast('time_ranges_channel', data)
    render json: data
  rescue Booking::Creator::NotAvailableRangeError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def create_params
    params.require(:booking).permit(:username, time_range_ids: [])
  end
end
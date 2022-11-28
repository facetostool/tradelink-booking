class Api::V1::TimeRangesController < Api::V1::BaseController
  def index
    render json: Api::V1::TimeRangeSerializer.new(TimeRange.order(:id).by_date(index_params[:date]))
  end

  private

  def index_params
    params.require(:filters).permit(:date)
  end
end
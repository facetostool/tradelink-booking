require 'rails_helper'

describe 'Time Ranges', type: :request do
  describe 'GET /api/v1/time_ranges' do
    let(:range) { create(:time_range) }

    let(:params) do
      {
        filters: {
          date: range.date.to_s,
        }
      }
    end


    it 'works' do
      get api_v1_time_ranges_path, params: params
      expect(response).to have_http_status(200)
      expect(json[:data].size).to eq(1)
      expect(json[:data].first).to include(
        id: anything,
        type: 'time_range',
        attributes: hash_including(
          booking_id: anything,
          date: anything,
          start_time: anything,
          end_time: anything,
        )
      )
    end
  end
end
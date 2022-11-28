require 'rails_helper'

describe 'Bookings', type: :request do
  describe 'GET /api/v1/bookings' do
    before { create(:booking) }

    it 'works' do
      get api_v1_bookings_path
      expect(response).to have_http_status(200)
      expect(json[:data].size).to eq(1)
      expect(json[:data].first).to include(
        id: anything,
        type: 'booking',
        attributes: hash_including(
          username: anything,
        )
      )
    end
  end

  describe 'POST /api/v1/bookings' do
    let(:range) { create(:time_range) }
    let(:params) do
      {
        booking: {
          username: 'test',
          time_range_ids: [range.id]
        }
      }
    end

    it 'works' do
      post api_v1_bookings_path, params: params
      expect(response).to have_http_status(200)
      expect(json[:data]).to include(
        id: anything,
        type: 'booking',
        attributes: hash_including(
          username: 'test',
        )
      )
    end
  end
end
require 'rails_helper'

RSpec.describe Api::V1::BookingsController, type: :controller do
  describe 'GET #index' do
    before { create(:booking) }

    it 'index http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:range) { create(:time_range) }

    let(:params) do
      {
        booking: {
          username: 'test',
          time_range_ids: [range.id]
        }
      }
    end

    it 'returns http success' do
      post :create, params: params
      expect(response).to have_http_status(:success)
      expect(json).to include(
        data: hash_including(
          id: anything,
          type: 'booking',
          attributes: {
            username: 'test',
          }
        )
      )
    end
  end
end

require 'rails_helper'

RSpec.describe Api::V1::TimeRangesController, type: :controller do
  describe 'GET #index' do
    before { create(:time_range) }

    it 'index http success' do
      get :index, params: { filters: { date: 'something' } }
      expect(response).to have_http_status(:success)
    end
  end
end
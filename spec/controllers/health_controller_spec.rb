require 'rails_helper'

RSpec.describe HealthController, type: :controller do
  describe 'GET #health' do
    it 'returns http success' do
      get :show
      expect(response).to have_http_status(:success)
    end
  end
end

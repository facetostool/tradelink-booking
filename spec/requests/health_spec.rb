require 'rails_helper'

describe 'Health', type: :request do
  describe 'GET /health' do
    it 'works' do
      get health_path
      expect(response).to have_http_status(200)
    end
  end
end
module Requests
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body).deep_symbolize_keys
    end
  end
end

RSpec.configure do |config|
  config.include Requests::JsonHelpers, type: :controller
  config.include Requests::JsonHelpers, type: :request
end
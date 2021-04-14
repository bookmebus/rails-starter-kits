require 'rails_helper'
require 'ostruct'

RSpec.describe API::AuthenticatedController, type: :controller do

  controller do
    def index
      render json: {message: :ok}
    end
  end

  let!(:payload) do
    {
      "iss": "bmb-starter-logistic.github.com",
      "aud": "ssr-client",
      "sub": "api",
      "name": "Quote app",
      "role": "dynamic"
    }
  end

  let!(:exp) { 2.day.from_now}

  context "valid token" do
    it "allows request" do
      token = JwtGenerator.encode(payload)
      request.headers['Authorization'] = "Bearer #{token}"

      get :index

      result = JSON.parse(response.body)
      expect(result).to match({"message"=>"ok"})
      expect(response.status).to eq 200
    end
  end

  context 'with invalid token' do
    it 'raised Unauthorised error' do
      token = 'invalid'

      request.headers['Authorization'] = "Bearer #{token}"
      get :index

      result = JSON.parse(response.body)
      expect(result).to match({"error"=>"unauthorized", "error_message"=>"Not enough or too many segments"})
      expect(response.status).to eq 401
    end
  end

  context 'without token' do
    it 'raised Unauthorised parse error' do
      get :index

      result = JSON.parse(response.body)
      expect(result).to match({"error"=>"unauthorized", "error_message"=>"UnauthorizedError"})
      expect(response.status).to eq 401
    end
  end

  context 'with expired token' do
    it 'raised Unauthorised parse error' do
      payload[:exp] = 3.day.ago.to_i
      token = JwtGenerator.encode(payload)
      request.headers['Authorization'] = "Bearer #{token}"

      get :index

      result = JSON.parse(response.body)
      expect(result).to match({"error"=>"unauthorized", "error_message"=>"Signature has expired"})
      expect(response.status).to eq 401
    end
  end

end

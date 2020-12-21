require 'rails_helper'

RSpec.describe JwtGenerator, type: 'lib' do
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

  it 'encode and return token' do
    token = JwtGenerator.encode(payload)
    expect(token.present?).to be true
  end

  describe "#decode" do
    it 'decode and return payload if token is valid' do
      token = JwtGenerator.encode(payload)
      result = JwtGenerator.decode( token)
  
      expect(result).to match payload
    end

    it 'raise DecodeError if token is invalid' do
      expect{JwtGenerator.decode("invalid")}.to raise_error(JWT::DecodeError)
    end

    it 'raise JWT::ExpiredSignature if token is expired ' do
      payload[:exp] = 3.day.ago.to_i

      token = JwtGenerator.encode(payload)
      
      expect{JwtGenerator.decode(token)}.to raise_error(JWT::ExpiredSignature)
    end
  end


end
require 'rails_helper'

RSpec.describe "API::Sessions", type: :request do
  let(:profile_pic) do
    file = Rails.root.join('spec', 'support', 'assets', 'user', 'profile_pic.jpg')

    ActiveStorage::Blob.create_and_upload!(
      io: File.open(file, 'rb'),
      filename: 'profile_pic.jpg',
      content_type: 'image/jpeg' # Or figure it out from `name` if you have non-JPEGs
    ).signed_id
  end

  let(:user) { create(:user, password: 'awesome-pwd', display_name: 'Joeoun', profile_pic: profile_pic, confirmed_at: Time.zone.now)}

  describe "POST /create" do
    it 'renders a successful response in json format' do
      post api_user_session_url, params: { api_user: { login: user.email, password: 'awesome-pwd' } }
      json = json_response

      expect(json['id']).to eq user.id
      expect(json['display_name']).to eq 'Joeoun'
      expect(json['profile_pic_collection_urls'].present?).to be true
      expect(json['access_token'].present?).to be true

      decoded = JwtGenerator.decode(json['access_token'])
      expect(decoded['jti']).to eq user.jti
    end

    it 'render errors with invalid request' do
      post api_user_session_url, params: { api_user: { login: user.email, password: 'wrong-pwd' } }
      json = json_response
  
      expect(json).to eq({"error"=>"Invalid Login or password."})
    end
  end
end

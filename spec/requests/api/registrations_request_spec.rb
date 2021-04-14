require 'rails_helper'

RSpec.describe "API::Registrations", type: :request do

  let(:profile_pic) do
    file = Rails.root.join('spec', 'support', 'assets', 'user', 'profile_pic.jpg')

    ActiveStorage::Blob.create_and_upload!(
      io: File.open(file, 'rb'),
      filename: 'profile_pic.jpg',
      content_type: 'image/jpeg' # Or figure it out from `name` if you have non-JPEGs
    ).signed_id
  end

  describe 'POST /create' do

    it 'create registration with valid attrs' do
      User.all.delete_all
      post api_user_registration_url, params: { phone_number: '0975553553', password: '123456789', profile_pic: profile_pic}

      json = json_response

      expect(json['id'].present?).to be true
    end

    it 'render errors with invalid attrs' do
      post api_user_registration_url, params: { phone_number: '', email: '', password: '123456789', profile_pic: profile_pic}
      json_errors = json_response['errors']

      expect(json_errors['email']).to eq ["can't be blank"]
      expect(json_errors['phone_number']).to eq ["can't be blank"]
    end

  end

end

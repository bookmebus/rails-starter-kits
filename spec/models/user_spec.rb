require 'rails_helper'

RSpec.describe User, type: :model do
  it 'set role if role does not exist' do
    user = create(:user)
    expect(user.role).to eq Role.ensure_user_role
  end

  describe 'Username validation' do
    it 'requires username to container only letters and numbers' do
      user = build(:user, username: 'joeann@gmail.com')
      expect(user.valid?).to eq false
      expect(user.errors.messages[:username]).to eq ["is invalid"]
    end

    it 'requires username to be unique' do
      create(:user, username: 'joeann')
      user = build(:user, username: 'joeann')
      expect(user.valid?).to eq false
      expect(user.errors.messages[:username]).to eq ["taken"]
    end
  end
  
  describe 'Email validation' do
    it 'requires email if phone_number is blank' do
      user = build(:user, phone_number: nil, email: nil)
      expect(user.valid?).to eq false
      expect(user.errors.messages[:email]).to eq ["can't be blank"]
    end

    it 'does requires email if phone_number is exists' do
      user = build(:user, email: nil)
      expect(user.valid?).to eq true
    end

    it 'requires email to be unique' do
      exist_email = 'my-unique@gmail.com'
      create(:user, email: exist_email)
      user = build(:user, email: exist_email)
      expect(user.valid?).to eq false

      expect(user.errors.messages[:email]).to eq ["taken"]
    end
  end

  describe 'Phone number validation' do
    it 'requires phone number if email is blank' do
      user = build(:user, phone_number: nil, email: nil)
      expect(user.valid?).to eq false
      expect(user.errors.messages[:phone_number]).to eq ["can't be blank"]
    end

    it 'does requires phone_number if email is exists' do
      user = build(:user, phone_number: nil)
      expect(user.valid?).to eq true
    end
  end

  describe 'Password validation' do
    it 'requires password on create' do
      user = build(:user, password: nil)
      expect(user.valid?).to eq false
      expect(user.errors.messages[:password]).to eq ["can't be blank"]
    end

    it 'does not require password when updating' do
      user = create(:user, first_name: 'peace', last_name: 'now')
      result = user.update(first_name: 'stop', last_name: 'war')
      expect(result).to eq true
    end
  end

  describe 'Profile pic uploader' do
    before(:each) { ActiveStorage::Current.host = ENV['HOST'] }
    let(:profile_pic) do
      file = Rails.root.join('spec', 'support', 'assets', 'user', 'profile_pic.jpg')
  
      ActiveStorage::Blob.create_and_upload!(
        io: File.open(file, 'rb'),
        filename: 'profile_pic.jpg',
        content_type: 'image/jpeg' # Or figure it out from `name` if you have non-JPEGs
      ).signed_id
    end

    it 'accept profile pic attr' do
      user = create(:user, profile_pic: profile_pic)
      user.save
      expect(user.profile_pic_collection_urls[:icon].present?).to be true
      expect(user.profile_pic_collection_urls[:thumb].present?).to be true
    end
  end

  describe '.find_first_by_auth_conditions' do
    describe 'record exists' do
      it 'return user when login matches username' do
        user = create(:user, username: 'ErichTheking')

        result = User.find_first_by_auth_conditions(login: 'erichtheking')
        expect(result).to eq user
      end

      it 'return user when login matches the phone_number' do
        user = create(:user, phone_number: '012777666')

        result = User.find_first_by_auth_conditions(login: '012777666')
        expect(result).to eq user

      end

      it 'return user when login matches the email' do
        user = create(:user, email: 'joeann@awesome.com')

        result = User.find_first_by_auth_conditions(login: 'joeann@awesome.com')
        expect(result).to eq user

      end
    end

    describe 'record does not exist' do
      it 'return nil' do
        result = User.find_first_by_auth_conditions(login: 'nonexisting@awesome.com')
        expect(result).to eq nil
      end
    end

  end

end

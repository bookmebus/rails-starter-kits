require 'rails_helper'

RSpec.describe AuthorizePolicy, type: :interactor do
  describe '.call' do
    it 'return failed with user_nil if user is nil' do

      result = AuthorizePolicy.call(user: nil)
      expect(result.success?).to eq false
      expect(result.message).to eq 'user_nil'
    end

    it 'return failed with role_nil if user is nil' do
      user = build(:user)

      result = AuthorizePolicy.call(user: user)
      expect(result.success?).to eq false
      expect(result.message).to eq 'role_nil'
    end

    it 'return true if user role authorized true' do
      role = build(:role, role_type: :super_admin_role)
      user = build(:user, role: role)
      result = AuthorizePolicy.call(user: user)

      expect(result.success?).to eq true
      expect(result.message).to eq nil
    end
  end
end

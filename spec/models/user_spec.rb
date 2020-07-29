require 'rails_helper'

RSpec.describe User, type: :model do
  it 'set role if role does not exist' do
    user = create(:user)
    expect(user.role).to eq Role.ensure_default_role
  end
end

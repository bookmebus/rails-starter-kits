require 'rails_helper'

RSpec.describe Role, type: :model do
  let!(:attr) do
    { name: {en: "admin"}, description: { en: 'Admin role'} }
  end

  it "is valid with attributes" do
    role = build(:role)
    expect(role.valid?).to be true
    expect(role.access).to eq({})
  end

  it 'requires name to be present' do
    role = build(:role, name: {})
    expect(role.valid?).to eq false

    expect(role.errors.full_messages).to match(["Name can't be blank"])
  end

  it 'requires description to be present' do
    role = build(:role, description: {})
    expect(role.valid?).to eq false

    expect(role.errors.full_messages).to match(["Description can't be blank"])
  end

  describe '.ensure_default_role' do
    it 'return create and return the default role if it does not exist' do
      count = Role.count
      default_role = Role.ensure_default_role
      expect(Role.count).to eq(count + 1 )
      expect(default_role.default_role?).to eq true
      expect(default_role.name).to eq 'Default'
      expect(default_role.description).to eq 'Default role for user'
    end

    it 'return the default role if it already exists' do
     
      Role.ensure_default_role
      count = Role.count

      default_role = Role.ensure_default_role

      expect(Role.count).to eq count
      expect(default_role.default_role?).to eq true
      expect(default_role.name).to eq 'Default'
      expect(default_role.description).to eq 'Default role for user'
    end

  end

  describe '#autorize?' do
    it 'return true if role_type is role_super_admin' do
      role = build(:role, role_type: :super_admin_role)
      
      result = role.authorize?('User', 'show')
      expect(result).to eq true
    end

    it 'return false if access is empty' do

      role = build(:role)
      result = role.authorize?('User', 'show')
      expect(result).to eq false
    end

    it 'return false if key does not exist' do
      role = build(:role, access: { 'Company': {'show': 1 } } )

      result = role.authorize?('User', 'show')
      expect(result).to eq false
    end

    it 'return false if key does not exist' do
      role = build(:role, access: { 'User': { 'show': 1 } } )

      result = role.authorize?('User', 'show')
      expect(result).to eq true
    end

  end

end

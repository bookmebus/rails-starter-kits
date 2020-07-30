require 'rails_helper'

RSpec.describe Quote::Address, type: :model do
  it 'valid with valid attributes' do
    address = build(:quote_address)

    expect(address.valid?).to be true
  end

  it 'require name to be present' do
    address = build(:quote_address, name: nil)
    expect(address.valid?).to be false
    expect(address.errors.full_messages).to eq ["Name can't be blank"]
  end

  it 'require lat to be present' do
    address = build(:quote_address, lat: nil)
    expect(address.valid?).to be false
    expect(address.errors.full_messages).to eq ["Latitude can't be blank"]
  end

  it 'require lon to be present' do
    address = build(:quote_address, lon: nil)
    expect(address.valid?).to be false
    expect(address.errors.full_messages).to eq ["Longitude can't be blank"]
  end
end

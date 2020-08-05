require 'rails_helper'

RSpec.describe Quote::Contact, type: :model do
  it 'is valid for valid attributes' do
    contact = build(:quote_contact)
    expect(contact.valid?).to be true
  end

  it 'requires name to be present' do
    contact = build(:quote_contact, name: nil)
    expect(contact.valid?).to be false
    expect(contact.errors.full_messages).to eq ["Name can't be blank"]
  end

  it 'does not require phone_number to be present if email exists' do
    contact = build(:quote_contact, phone_number: nil)
    expect(contact.valid?).to be true
  end

  it 'does not require email to be present if name exists' do
    contact = build(:quote_contact, email: nil)
    expect(contact.valid?).to be true
  end

  it 'requires title to be present' do
    contact = build(:quote_contact, title: nil)
    expect(contact.valid?).to be false
  end

  it 'is not valid if both email and phone number are missing' do
    contact = build(:quote_contact, email: nil, phone_number: nil)
    expect(contact.valid?).to eq false
    expect(contact.errors.full_messages).to eq ["Phone number can't be blank", "Email can't be blank"]
  end

end

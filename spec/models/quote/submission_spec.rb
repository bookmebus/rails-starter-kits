require 'rails_helper'

RSpec.describe Quote::Submission, type: :model do

  it 'is valid with valid attributes' do
    submission = build(:quote_submission)
    expect(submission.valid?).to eq true
  end

  it 'creates with accepts nested attributes' do
    attributes = {
      pickup_address_attributes: {
        name: "Wat Phnom, ផ្លូវវត្តភ្នំ, រាជធានី​ភ្នំពេញ",
        lat: "11.5659647",
        lon: "104.9150842",
      },

      delivery_address_attributes: {
        name: "Banlung, ក្រុងបានលុង, Ratanakiri",
        lat: "13.7375463",
        lon: "106.9775092"
      },

      shipment_items_attributes: [{
        width: 40,
        length: 20,
        height: 35,
        dimension_unit: 'cm',

        weight: 30,
        weight_unit: 'kg'
      }],

      contact_attributes: {
        name: 'Joean',
        email: 'joeann@gmail.com',
        phone_number: '0972223334',
        title: 'mrs.',

      }
    }

    submission = Quote::Submission.new(attributes)
    result = submission.save
    expect(result).to eq true
    expect(submission.pickup_address.name).to eq "Wat Phnom, ផ្លូវវត្តភ្នំ, រាជធានី​ភ្នំពេញ"
    expect(submission.delivery_address.name).to eq "Banlung, ក្រុងបានលុង, Ratanakiri"
    expect(submission.shipment_items.first.width).to eq 40
    expect(submission.contact.name).to eq 'Joean'
  end

  it 'update with nested attributes' do
    submission = create(:quote_submission)
    delivery_address = create(:quote_delivery_address, submission: submission)
    pickup_address = create(:quote_pickup_address, submission: submission)
    contact = create(:quote_contact, submission: submission)
    shipment_item = create(:quote_shipment_item, submission: submission)

    update_attrs = {
      pickup_address_attributes: {
        id: pickup_address.id,
        name: "Wat Phnom",
        lat: "11",
        lon: "101",
      },

      delivery_address_attributes: {
        id: delivery_address.id,
        name: "Banlung",
        lat: "15",
        lon: "105"
      },

      shipment_items_attributes: [{
        id: shipment_item.id,
        width: 20,
        length: 30,
        height: 40,
        dimension_unit: 'm',

        weight: 60,
        weight_unit: 'lbs'
      }],

      contact_attributes: {
        id: contact.id,
        name: 'Jhone',
        email: 'jhone@gmail.com',
        phone_number: '012987654',
        title: 'mr.',
      }
    }

    submission.update(update_attrs)
    
    expect(submission.pickup_address.name).to eq 'Wat Phnom'
    expect(submission.pickup_address.lat).to eq 11
    expect(submission.pickup_address.lon).to eq 101

    expect(submission.delivery_address.name).to eq 'Banlung'
    expect(submission.delivery_address.lat).to eq 15
    expect(submission.delivery_address.lon).to eq 105

    shipment = submission.shipment_items.first
    expect(shipment.width).to eq 20
    expect(shipment.length).to eq 30
    expect(shipment.height).to eq 40
    expect(shipment.weight).to eq 60
    
    expect(submission.contact.name).to eq 'Jhone'
    expect(submission.contact.email).to eq 'jhone@gmail.com'
    expect(submission.contact.phone_number).to eq '012987654'
    expect(submission.contact.title).to eq 'mr.'

  end

end

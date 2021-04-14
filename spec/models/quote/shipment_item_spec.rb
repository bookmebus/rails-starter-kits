require 'rails_helper'

RSpec.describe Quote::ShipmentItem, type: :model do

  it 'is valid if all dimensions are present' do
    shipment_item = build(:quote_shipment_item)
    expect(shipment_item.valid?).to eq true
  end

  it 'is valid if image is attached' do
    file = Rails.root.join('spec', 'support', 'assets', 'shipment_item', 'wine-box.jpeg')

    image = ActiveStorage::Blob.create_and_upload!(
      io: File.open(file, 'rb'),
      filename: 'wine-box.jpeg',
      content_type: 'image/jpeg' # Or figure it out from `name` if you have non-JPEGs
    ).signed_id

    shipment_item = Quote::ShipmentItem.new(image: image, submission: create(:quote_submission))
    expect(shipment_item.valid?).to eq true
  end

  it 'requires width if no image attached' do
    shipment_item = build(:quote_shipment_item, width: nil)
    expect(shipment_item.valid?).to be false
    expect(shipment_item.errors.full_messages).to eq ["Width can't be blank"]
  end

  it 'requires length if no image attached' do
    shipment_item = build(:quote_shipment_item, length: nil)
    expect(shipment_item.valid?).to be false
    expect(shipment_item.errors.full_messages).to eq ["Length can't be blank"]
  end

  it 'requires height if no image attached' do
    shipment_item = build(:quote_shipment_item, height: nil)
    expect(shipment_item.valid?).to be false
    expect(shipment_item.errors.full_messages).to eq ["Height can't be blank"]
  end

  it 'requires weight if no image attached' do
    shipment_item = build(:quote_shipment_item, weight: nil)
    expect(shipment_item.valid?).to be false
    expect(shipment_item.errors.full_messages).to eq ["Weight can't be blank"]
  end

  it 'requires weight_unit if no image attached' do
    shipment_item = build(:quote_shipment_item, weight_unit: nil)
    expect(shipment_item.valid?).to be false
    expect(shipment_item.errors.full_messages).to eq ["Weight unit can't be blank"]
  end

  it 'requires dimension_unit if no image attached' do
    shipment_item = build(:quote_shipment_item, dimension_unit: nil)
    expect(shipment_item.valid?).to be false
    expect(shipment_item.errors.full_messages).to eq ["Dimensional unit can't be blank"]
  end

end

class Quote::Submission < ApplicationRecord

  has_one :pickup_address, class_name: 'Quote::PickupAddress', dependent: :destroy
  has_one :delivery_address, class_name: 'Quote::DeliveryAddress', dependent: :destroy
  has_one :contact, class_name: 'Quote::Contact', dependent: :destroy

  has_many :shipment_items, class_name: 'Quote::ShipmentItem', dependent: :destroy
  enum status: [:open, :assigned, :completed, :confirmed, :closed ]

  accepts_nested_attributes_for :pickup_address, allow_destroy: true
  accepts_nested_attributes_for :delivery_address, allow_destroy: true
  accepts_nested_attributes_for :contact, allow_destroy: true
  accepts_nested_attributes_for :shipment_items, allow_destroy: true
  
end

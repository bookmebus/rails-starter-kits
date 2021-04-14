FactoryBot.define do
  factory :quote_shipment_item, class: 'Quote::ShipmentItem' do
    number_of_item { 1 }
    length { "9.99" }
    width { "9.99" }
    height { "9.99" }
    weight { "9.99" }
    weight_unit { "lbs" }
    dimension_unit { "cm" }
    description { "" }
    packaging_consultation { false }
    
    association :submission, factory: :quote_submission
  end
end

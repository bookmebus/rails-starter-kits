FactoryBot.define do
  factory :quote_pickup_address, class: 'Quote::PickupAddress' do
    name { "Wat Phnom, ផ្លូវវត្តភ្នំ, រាជធានី​ភ្នំពេញ" }
    lat { "11.5659647" }
    lon { "104.9150842" }
    association :submission, factory: :quote_submission
  end
end

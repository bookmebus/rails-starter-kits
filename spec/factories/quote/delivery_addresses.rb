FactoryBot.define do
  factory :quote_delivery_address, class: 'Quote::DeliveryAddress' do
    name { "Banlung, ក្រុងបានលុង, Ratanakiri" }
    lat { "13.7375463" }
    lon { "106.9775092" }
    association :submission, factory: :quote_submission
  end
end
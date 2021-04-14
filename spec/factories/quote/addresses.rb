FactoryBot.define do
  factory :quote_address, class: 'Quote::Address' do
    name { "Wat phnom" }
    lat { "11.5659647" }
    lon { "104.9150842" }

    association :submission, factory: :quote_submission
  end


end

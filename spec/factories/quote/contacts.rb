FactoryBot.define do
  factory :quote_contact, class: 'Quote::Contact' do
    name { "Joeann" }
    email { "joeann@gmail.com" }
    phone_number { "0975553553" }
    title { "mr" }
    association :submission, factory: :quote_submission
  end
end

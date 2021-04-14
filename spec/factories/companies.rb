FactoryBot.define do
  factory :company do
    sequence(:name) { |n| "company_#{n}" }
    sequence(:meta_description) { |n| "description-#{n}" }
    sequence(:about) { |n| "about-#{n}" }
  end
end

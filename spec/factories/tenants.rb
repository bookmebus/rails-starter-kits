FactoryBot.define do
  factory :tenant do
    sequence(:name) { |n| {en: "tenant_#{n}" } }
    sequence(:tenant_key) { |n| "tenant_key_#{n}" }
  end
end

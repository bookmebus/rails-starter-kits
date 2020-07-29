FactoryBot.define do
  factory :role do
    name { {en: 'admin'} }
    description { {en: 'Admin of the site'} }
    access { {} }
    active { false }
    role_type { 0 }
  end
end

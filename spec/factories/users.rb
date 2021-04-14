FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "example_#{n}@bookmebus.com"}
    sequence(:phone_number) { |n| "01212345#{n}"}
    password { 'fake-pwd'}
    # profile_pic { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'profile_pic'), 'image/jpeg') }
  end
end

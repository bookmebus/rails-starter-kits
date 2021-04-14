FactoryBot.define do
  factory :quote_submission, class: 'Quote::Submission' do
    status { :open }
  end
end

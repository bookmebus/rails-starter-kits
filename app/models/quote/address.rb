class Quote::Address < ApplicationRecord

  include Translateable
  translateable :name

  belongs_to :submission, class_name: 'Quote::Submission'

  validates :name, presence: true
  validates :lat, presence: true
  validates :lon, presence: true
end

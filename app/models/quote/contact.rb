class Quote::Contact < ApplicationRecord
  belongs_to :submission, class_name: 'Quote::Submission'

  validates :name, presence: true
  validates :phone_number, presence: true, if: ->(contact) { contact.email.blank? }
  validates :email, presence: true, if: ->(contact) { contact.phone_number.blank? }
  validates :title, presence: true

  def self.honorific_titles
    I18n.t('common.honorific_titles').map{|key, value| [value, key]}
  end

  def display_contact
    items = []
    items << self.phone_number if self.phone_number
    items << self.email if self.email
    items.join("-")
  end
end

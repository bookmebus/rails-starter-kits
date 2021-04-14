class Quote::ShipmentItem < ApplicationRecord
  include Translateable
  translateable :description

  has_one_attached :image
  belongs_to :submission, class_name: 'Quote::Submission', counter_cache: true

  validates :width, presence: true, if: ->(item) { !item.image.attached?}
  validates :length, presence: true, if: ->(item) { !item.image.attached?}
  validates :height, presence: true, if: ->(item) { !item.image.attached?}

  validates :weight, presence: true, if: ->(item) { !item.image.attached?}

  validates :weight_unit, presence: true, if: ->(item) { !item.image.attached?}
  validates :dimension_unit, presence: true, if: ->(item) { !item.image.attached?}

  def self.weight_units
    I18n.t('common.weight_units').map{|key, value| [value, key] }
  end

  def self.dimensional_units
    I18n.t('common.dimensional_units').map{|key, value| [value, key] }
  end

end

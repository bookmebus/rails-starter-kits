class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_save :versioning_storage

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  has_one_attached :profile_pic

  def versioning_storage
    return if !profile_pic.attached?
    [
      [30,30], [120, 120], [200, 200]
    ].each do |version|
      profile_pic.variant(resize_to_limit: version).processed
    end

  end
end

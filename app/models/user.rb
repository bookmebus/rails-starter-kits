class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  has_one_attached :profile_pic
  belongs_to :role


  before_validation :set_user_role
  after_save :versioning_storage

  def set_user_role
    return if self.role_id.present?
    self.role = Role.ensure_default_role
  end

  def versioning_storage
    return if !profile_pic.attached?
    [
      [30,30], [120, 120], [200, 200]
    ].each do |version|
      profile_pic.variant(resize_to_limit: version).processed
    end
  end


end

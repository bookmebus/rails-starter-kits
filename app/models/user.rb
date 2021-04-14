class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :confirmable, :lockable, :timeoutable, :trackable,
         :jwt_authenticatable, jwt_revocation_strategy: self, authentication_keys: [:login]

  self.skip_session_storage = [:http_auth, :params_auth]

  has_one_attached :profile_pic
  belongs_to :role


  validates :email, presence: true, if: ->(u) { u.phone_number.blank? }
  validates :email, uniqueness: true, if: ->(u) { u.email.present? }
  validates :phone_number, presence: true, if: ->(u) { u.email.blank? }
  validates :username, uniqueness: { case_sensitive: false, allow_blank: true }
  validates :password, presence: true , on: :create

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  before_validation :set_user_role
  after_save :versioning_storage
  before_create :set_jti

  attr_writer :login
  attr_accessor :dispatched_jwt_access_token

  PRE_PROCESS_IMAGE = false

  PROFILE_PIC_ICON = 30
  PROFILE_PIC_THUMB = 120
  PROFILE_PIC_STANDARD= 200
  PROFILE_PIC_SCREEN= 800

  def self.profile_pic_variants
    [PROFILE_PIC_ICON, PROFILE_PIC_THUMB, PROFILE_PIC_STANDARD, PROFILE_PIC_SCREEN]
  end

  # https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  def login
    @login || self.phone_number || self.email || self.username
  end

  def account_name
    return display_name if display_name.present?
    return username if username.present?

    return '' if email.blank?
    
    (result, _) = email.split("@")
    result

  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup

    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value OR phone_number = :value ", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def set_jti
    self.jti = SecureRandom.uuid if self.jti.blank?
  end

  def set_user_role
    self.role ||= Role.ensure_user_role
  end

  def profile_pic_collection_urls
    return if !profile_pic.attached?

    {
      icon: profile_pic_icon_url,
      thumb: profile_pic_thumb_url
    }
  end

  def profile_pic_thumb_url
    return if !profile_pic.attached?
    # ActiveStorage::Current.host = ENV['HOST']

    
    profile_pic.variant(resize_to_limit: [User::PROFILE_PIC_THUMB, User::PROFILE_PIC_THUMB])
    
  end

  def profile_pic_icon_url
    return if !profile_pic.attached?
    # ActiveStorage::Current.host = ENV['HOST']
    profile_pic.variant(resize_to_limit: [User::PROFILE_PIC_ICON, User::PROFILE_PIC_ICON])
  end

  def versioning_storage
    return if !User::PRE_PROCESS_IMAGE

    return if !profile_pic.attached?
    
    User::profile_pic_variants.each do |variant|
      profile_pic.variant(resize_to_limit: [variant, variant])
    end
  end

  def on_jwt_dispatch(token, payload)
    self.dispatched_jwt_access_token = token
  end

  # payload for jwt. default to { jti: xxx }
  def jwt_payload
    options = super
    result = options.merge(extra_jwt_payload)
    result
  end

  # add your customer payload here
  def extra_jwt_payload
    options = {
      account_name: account_name
    }

    options[:profile_pic_collection_urls] = profile_pic.attached? ? profile_pic_collection_urls : nil
    options
  end

end

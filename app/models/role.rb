class Role < TranslatableRecord
  translateable :name, :description

  validates :name, presence: true
  validates :description, presence: true

  enum role_type: [:normal_role, :default_role, :super_admin_role]

  has_many :users

  def self.ensure_default_role
    default_role = Role.where(role_type: Role.role_types[:default_role]).first_or_initialize
    if default_role.new_record?
      default_role.name = 'Default'
      default_role.description = 'Default role for user'
      default_role.save
    end
    default_role
  end

  def authorize?(key, action)
    return true if self.super_admin_role?

    query_key = entry_key(key)

    return false if access[query_key].blank?
    return false if access[query_key][action].blank?

    access[key][action] == 1
  end

  def entry_key(key)
    # return key.to_s.tableize if key.class == Symbol || key.class == String || key.class == Class
    # key.class.to_s.tableize
    return key
  end
end

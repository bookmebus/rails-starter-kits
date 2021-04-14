class Role < TranslatableRecord
  translateable :name, :description

  validates :name, presence: true
  validates :description, presence: true

  # You tried to define an enum named "role_type" on the model "Role", but this will generate a instance method "default_role?", which is already defined by Active Record.
  enum role_type: [:normal_role, :user_role, :super_admin_role]

  has_many :users

  def self.ensure_user_role
    role = Role.where(role_type: Role.role_types[:user_role]).first_or_initialize
    if role.new_record?
      role.name = 'Default'
      role.description = 'Default role for user'
      role.save
    end
    role
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

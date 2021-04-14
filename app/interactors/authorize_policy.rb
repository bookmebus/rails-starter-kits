class AuthorizePolicy
  include Interactor
  # user: User, entry: String, action: String
  def call
    # user, entry, action
    return context.fail!(message: "user_nil") if context.user.nil?
    return context.fail!(message: "role_nil") if context.user.role.nil?

    ok = context.user.role.authorize?(context.entry, context.action)
    return context.fail!(message: 'role_no_authroized') if !ok
  end
end

# frozen_string_literal: true

module AuthenticablePolicy
  extend ActiveSupport::Concern

  included do
    before_action :authorize_policy!
  end

  def authorize_policy!
    result = AuthorizePolicy.call(user: auth_user, entry: auth_entry, action: auth_action)
    if !result.success?
      raise UnauthorizedError.new(result.message)
    end
  end

  # can override this in the controller
  def auth_user
    # current_user
    nil
  end

  def auth_entry
    controller_name
  end

  def auth_action
    action_name
  end
end

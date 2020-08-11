class API::SessionsController < Devise::SessionsController
  include APIFormat

  prepend_before_action :require_no_authentication, only: [:create] # skip device auth check

  # new() method is the default method to call if Devise fails to authenticate user
  def new
    render json: {response: "Authentication required"}, status: 401
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?

    # respond_with resource, location: after_sign_in_path_for(resource)
    render json: resource, serializer: UserAccessTokenSerializer
  end

  # def current_token
  #   request.env['warden-jwt_auth.token']
  # end

end

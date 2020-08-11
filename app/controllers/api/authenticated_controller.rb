class API::AuthenticatedController < ApplicationController
  include JwtAuthenticable
  include APIFormat

  rescue_from UnauthorizedError, with: :render_unauthorized


  def render_unauthorized(e)
    render json: {error: 'unauthorized', error_message: e.message }, status: :unauthorized
  end
end
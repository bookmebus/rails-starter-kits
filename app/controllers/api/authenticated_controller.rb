class API::AuthenticatedController < ApplicationController
  include JwtAuthenticable
  include APIFormat

  rescue_from UnauthorizedError, with: :render_unauthorized
end
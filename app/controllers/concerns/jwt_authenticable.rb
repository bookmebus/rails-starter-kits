module JwtAuthenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_app!
  end

  def authenticate_app!
    jwt_token = request.headers["Authorization"]
    raise UnauthorizedError if jwt_token.blank?

    (_, encodedJWT ) = jwt_token.split('Bearer ')

    begin
      payload = JwtGenerator.decode(encodedJWT)

      # we can get any claim from here: app_id:, role:, user_id: to further restrict access
      payload
    rescue JWT::DecodeError => e
      raise UnauthorizedError.new(e.message)
    rescue JWT::ExpiredSignature => e
      raise UnauthorizedError.new(e.message)
    end

  end
end
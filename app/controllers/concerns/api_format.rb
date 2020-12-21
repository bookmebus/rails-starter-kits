module APIFormat
  extend ActiveSupport::Concern

  included do
    respond_to :json
    skip_before_action :verify_authenticity_token
  end


  def render_unauthorized(e)
    render json: {error: 'unauthorized', error_message: e.message }, status: :unauthorized
  end

  def render_bad_request(errors)
    render json: {error: errors } , status: :bad_request
  end

  def render_error(record)
    render_bad_request(record.errors.messages)
  end
end
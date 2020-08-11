class ApplicationController < ActionController::Base
  include Localeable

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    added_attrs = [:phone_number, :email, :password, :password_confirmation, :remember_me]
    
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end

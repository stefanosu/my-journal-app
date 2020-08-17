class ApplicationController < ActionController::API 
  before_action :underscore_params!
  before_action :configured_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :null_session
  respond_to :json


  def underscore_params!
    params.deep_transform_keys!(&:underscore)
  end

  private 

  def configured_permitted_parameters 
    devise_paramater_sanitizer.permit(:sign_up, keys:[:username])
  end


end

class ApplicationController < ActionController::API 
  before_action :underscore_params!
  before_action :configured_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user 
  protect_from_forgery with: :null_session
  respond_to :json


  def underscore_params!
    params.deep_transform_keys!(&:underscore)
  end

  private 

  def configured_permitted_parameters 
    devise_paramater_sanitizer.for(:sign_up) << :username
  end

  def authenticate_user
    if request.headers['Authorization'].present?
      authenticate_or_request_with_http_token do |token|
        begin
          jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first

          @current_user_id = jwt_payload['id']
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          head :unauthorized
        end
      end
    end
  end
end 
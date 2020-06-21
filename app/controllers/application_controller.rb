class ApplicationController < ActionController::API 
  before_action :underscore_params!
  protect_from_forgery with: :null_session  


  def underscore_params!
    params.deep_transform_keys!(&:underscore)
  end

end

class ApplicationController < ActionController::Base
  before_action :user_parameters, if: :devise_controller?
  protected
    def user_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:cpf])
    end

end

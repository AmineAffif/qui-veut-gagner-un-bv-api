class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_request, except: %i[create]

  attr_reader :current_user

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    decoded = JsonWebToken.decode(token)
  
    if decoded
      @current_user = AdminUser.find_by(authentication_token: token) || User.find_by(authentication_token: token)
    end
  
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end  
end

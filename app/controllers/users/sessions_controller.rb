class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :skip_flash, only: [:create]
  respond_to :json

  # POST /resource/sign_in
  def create
    user = User.find_by('email = :login OR username = :login', login: params[:user][:login])
    if user&.valid_password?(params[:user][:password])
      token = JsonWebToken.encode(user_id: user.id)
      user.update(authentication_token: token) # Mettre à jour le jeton dans la base de données
      render json: { user: user, token: token }, status: :ok
    else
      render json: { error: 'Invalid login or password' }, status: :unauthorized
    end
  end

  private

  def respond_with(resource, _opts = {})
    render json: { user: resource }
  end

  def respond_to_on_destroy
    head :no_content
  end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password])
  end

  def skip_flash
    request.env["devise.skip_flash"] = true
  end
end

class AdminUsers::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_request, only: [:create]

  respond_to :json

  def create
    admin_user = AdminUser.find_by(email: params[:admin_user][:email])
    if admin_user&.valid_password?(params[:admin_user][:password])
      token = JsonWebToken.encode(user_id: admin_user.id)
      admin_user.update(authentication_token: token) # Mettre à jour le jeton dans la base de données
      render json: { user: admin_user, authentication_token: token, is_admin: true }, status: :ok
    else
      render json: { error: 'Invalid login or password' }, status: :unauthorized
    end
  end

  def destroy  
    if @current_user.is_a?(AdminUser)
      @current_user.update(authentication_token: nil) # Clear the token in the database
      sign_out(@current_user)
      render json: {}, status: :ok
    else
      render json: { error: 'Not signed in' }, status: :unauthorized
    end
  end
    
  protected

  def verify_signed_out_user
    # Skip the Devise implementation of this check which renders HTML
  end

  def respond_with(resource, _opts = {})
    render json: { admin_user: resource }, status: :ok
  end

  def respond_to_on_destroy
    head :no_content
  end
end

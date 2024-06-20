# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :skip_flash, only: [:create]
  respond_to :json

  # POST /resource
  def create
    build_resource(sign_up_params)
    
    if resource.save
      token = JsonWebToken.encode(user_id: resource.id)
      resource.update(authentication_token: token)
      render json: { user: resource, token: token }, status: :ok
    else
      clean_up_passwords resource
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :first_name, :last_name, :username])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :first_name, :last_name, :username])
  end

  private

  def respond_with(resource, _opts = {})
    render json: { user: resource }
  end

  def respond_to_on_destroy
    head :no_content
  end

  def skip_flash
    request.env["devise.skip_flash"] = true
  end
end

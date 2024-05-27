# frozen_string_literal: true

class AdminUsers::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    if resource
      sign_in(resource_name, resource)
      render json: { admin_user: resource, is_admin: true }, status: :ok
    else
      render json: { error: 'Invalid Email or password.' }, status: :unauthorized
    end
  end

  def destroy
    sign_out(resource_name)
    render json: {}, status: :ok
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


  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

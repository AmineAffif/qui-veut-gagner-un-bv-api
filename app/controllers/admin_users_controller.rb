class AdminUsersController < ApplicationController
  before_action :check_if_admin, only: [:update, :destroy]

  def index
    admin_users = AdminUser.all
    render json: admin_users, only: [:id, :email, :created_at, :updated_at]
  end

  def show
    if current_user
      admin_user = AdminUser.find(params[:id])
      render json: admin_user
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def create
    @admin_user = AdminUser.new(admin_user_params)

    if @admin_user.save
      render json: @admin_user.to_json, status: :created
    else
      render json: @admin_user.errors, status: :unprocessable_entity
    end
  end

  def update
    admin_user = AdminUser.find(params[:id])
    if admin_user.update(admin_user_params)
      render json: admin_user, status: :ok
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    admin_user = AdminUser.find(params[:id])
    if admin_user.destroy
      render json: { message: 'User deleted successfully' }, status: :ok
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def admin_user_params
    params.require(:admin_user).permit(:email, :password, :firstname, :lastname)
  end

  def check_if_admin
    unless current_user.is_a?(AdminUser)
      render json: { error: 'Forbidden' }, status: :forbidden
    end
  end
end

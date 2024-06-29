class UsersController < ApplicationController
  # before_action :authenticate_request, only: [:update_avatar]

  def index
    users = User.all
    render json: users, only: [:id, :email, :created_at, :updated_at]
  end

  def show
    if current_user
      user = User.find(params[:id])
      render json: user, include: :statistic
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user, status: :ok
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      render json: { message: 'User deleted successfully' }, status: :ok
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_avatar
    @user = current_user
    if params[:avatar].present?
      uploaded_file = Cloudinary::Uploader.upload(params[:avatar].path, public_id: "user_avatars/#{@user.id}", overwrite: true, transformation: { width: 100, height: 100, crop: :fill })
      @user.update(avatar: uploaded_file['secure_url']) # Store the full URL
      render json: { url: @user.avatar_url }, status: :ok
    else
      render json: { error: "No file uploaded" }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end

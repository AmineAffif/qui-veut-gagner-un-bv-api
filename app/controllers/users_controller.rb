class UsersController < ApplicationController
  # before_action :authenticate_request, only: [:update_avatar]

  def show
    if current_user
      user = User.find(params[:id])
      render json: user, include: :statistic
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
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
end

class UsersController < ApplicationController
  def show
    if current_user
      user = User.find(params[:id])
      render json: user, include: :statistic
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end

class UsersController < ApplicationController

  def show

    # Check if user is signed in
    if current_user
      user = User.find(params[:id])
      render json: user, include: :statistic
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end

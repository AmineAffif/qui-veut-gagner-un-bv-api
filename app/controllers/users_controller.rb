class UsersController < ApplicationController

  def show
    p 'current_user =========='
    p current_user
    p 'current_user =========='

    user = User.find(params[:id])
    render json: user, include: :statistic
  end
end

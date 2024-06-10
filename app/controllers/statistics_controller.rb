class StatisticsController < ApplicationController
  before_action :set_statistic, only: [:show, :update]

  # GET /statistics/:id
  def show
    if @statistic.user == current_user
      render json: @statistic
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  # PATCH/PUT /statistics/:id
  def update
    if @statistic.user == current_user
      if @statistic.update(statistic_params)
        render json: @statistic
      else
        render json: @statistic.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  private

  def set_statistic
    @statistic = Statistic.find(params[:id])
  end

  def statistic_params
    params.require(:statistic).permit(:global_score, :rank)
  end
end

class StatisticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_statistic, only: [:show, :update]

  # GET /statistics/1
  def show
    render json: @statistic
  end

  # PATCH/PUT /statistics/1
  def update
    if @statistic.update(statistic_params)
      render json: @statistic
    else
      render json: @statistic.errors, status: :unprocessable_entity
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

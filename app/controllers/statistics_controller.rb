class StatisticsController < ApplicationController
  before_action :set_statistic, only: [:show, :update]

  # GET /statistics/:id
  def show
    if @statistic.user == current_user
      games_count = @statistic.user.games.count
      correct_answers_count = @statistic.user.games.sum(:score)
      total_questions_count = games_count * 10
      correct_answers_percentage = total_questions_count.zero? ? 0 : (correct_answers_count.to_f / total_questions_count * 100).round(2)

      render json: { statistic: @statistic, games_count: games_count, correct_answers_percentage: correct_answers_percentage }
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

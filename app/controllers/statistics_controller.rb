class StatisticsController < ApplicationController
  before_action :set_statistic, only: [:show, :update]

  # GET /statistics/:id
  def show
    @statistic = @statistic.first
    if current_user
      games_count = @statistic.user.games.count
      total_questions_count = @statistic.user.games.count * 10
      correct_answers_count = @statistic.user.user_questions.where(correct: true).count
      incorrect_answers_count = total_questions_count - correct_answers_count
      correct_answers_percentage = (correct_answers_count.to_f / total_questions_count * 100).round(2)
      best_score = @statistic.user.games.maximum(:score) || 0
      average_score = @statistic.user.games.average(:score)&.round(2) || 0

      render json: {
        statistic: @statistic.as_json.merge(rank_value: @statistic.rank_value),
        games_count: games_count,
        total_questions_count: total_questions_count,
        correct_answers_count: correct_answers_count,
        incorrect_answers_count: incorrect_answers_count,
        correct_answers_percentage: correct_answers_percentage,
        best_score: best_score,
        average_score: average_score,
        global_score: @statistic.global_score
      }
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  # PATCH/PUT /statistics/:id
  def update
    if current_user
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
    @statistic = Statistic.where(user_id: params[:id])
  end

  def statistic_params
    params.require(:statistic).permit(:global_score, :rank)
  end
end

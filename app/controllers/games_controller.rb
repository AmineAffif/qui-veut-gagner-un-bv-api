class GamesController < ApplicationController
  before_action :authenticate_request

  def random_game
    if @current_user
      answered_question_ids = @current_user.user_questions.where(correct: true).pluck(:question_id)
      questions = Question.where.not(id: answered_question_ids)
                          .includes(:answers)
                          .order('RANDOM()')
                          .limit(10)
      if questions.empty?
        render json: { questions: [] }, status: :ok
      else
        render json: { questions: questions.as_json(include: :answers) }, status: :ok
      end
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def create
    if @current_user
      game = Game.new(game_params.merge(user: @current_user))
      if game.save
        correct_answers = params[:answers].select { |q_id, a_id| 
          Question.find(q_id).right_answer_id == a_id 
        }
        correct_answers.each do |q_id, _|
          @current_user.user_questions.create(question_id: q_id, correct: true)
        end
        render json: game, status: :created
      else
        render json: game.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def reset_questions
    if @current_user
      @current_user.user_questions.destroy_all
      render json: { message: 'Questions reset successfully' }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  def game_params
    params.require(:game).permit(:score, question_ids: [])
  end
end

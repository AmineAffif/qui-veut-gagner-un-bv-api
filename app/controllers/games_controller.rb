class GamesController < ApplicationController
  def random_game
    # questions = Question.includes(:answers).order('RANDOM()').distinct.limit(10)
    # render json: { questions: questions.as_json(include: :answers) }
    questions = Question.includes(:answers).to_a.sample(10)
    render json: { questions: questions.as_json(include: :answers) }
  end

  def create
    game = Game.new(game_params)
    if game.save
      render json: game, status: :created
    else
      render json: game.errors, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(:user_id, :score, question_ids: [])
  end
end

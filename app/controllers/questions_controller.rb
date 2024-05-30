class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :update]

  # GET /questions
  def index
    @questions = Question.all
    render json: @questions
  end

  # GET /questions/:id
  def show
    render json: @question.to_json(include: :answers)
  end

  # PATCH/PUT /questions/:id
  def update
    if @question.update(question_params)
      render json: @question.to_json(include: :answers)
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:text, :right_answer_id, answers_attributes: [:id, :text, :_destroy])
  end
end

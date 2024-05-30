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

  def create
    @question = Question.new(question_params.except(:right_answer_id))

    if @question.save
      if params[:question][:right_answer_id].present?
        right_answer = @question.answers.find_by(text: params[:question][:answers_attributes][params[:question][:right_answer_id].to_i][:text])
        @question.update(right_answer_id: right_answer.id) if right_answer
      end
      render json: @question.to_json(include: :answers), status: :created
    else
      render json: @question.errors, status: :unprocessable_entity
    end
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

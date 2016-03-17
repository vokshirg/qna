class AnswersController < ApplicationController
  before_action :set_answer, only: [:edit, :update, :destroy]
  before_action :set_question, only: [:new, :create, :edit]

  def new
    @answer = Answer.new()
  end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      go_to_question
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      go_to_question
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    go_to_question
  end

  private

  def go_to_question
    redirect_to question_answers_path(@answer.question)
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end

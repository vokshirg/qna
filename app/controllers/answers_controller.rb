class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_author?, only: [:edit, :update, :destroy]
  before_action :set_answer, only: [:edit, :update, :destroy]
  before_action :set_question, only: [:new, :create, :edit]

  def new
    @answer = Answer.new
  end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to @answer.question
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer.question
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to @answer.question
  end

  private

  def is_author?
    @answer = Answer.find(params[:id])
    if @answer.user != current_user
      flash[:alert] = 'You are not author of this answer'
      # render :show
      redirect_to @answer.question
    end
  end

  def answer_params
    params.require(:answer).permit(:body, :user_id)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end

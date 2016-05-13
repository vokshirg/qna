class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:edit, :update, :destroy, :right_answer, :not_right_answer]
  before_action :check_author?, only: [:edit, :update, :destroy]
  before_action :set_question, only: [:new, :create]

  def new
    @answer = Answer.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      render :create
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @answer.update(answer_params)
      render :update
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    # redirect_to @answer.question
  end

  def right_answer
    if current_user.is_author?(@answer.question)
      if @answer.question.right_answer
        @answer.question.answers.where("right_answer = ?", true).each do |a|
          a.right_answer = false
          a.save
        end
      end
      @answer.right_answer = true
      @answer.save
    else
      redirect_to @answer.question, alert: 'You are not author of this answer'
    end
  end

  def not_right_answer
    if current_user.is_author?(@answer.question)
      @answer.right_answer = false
      @answer.save
      render :right_answer
    else
      redirect_to @answer.question, alert: 'You are not author of this answer'
    end
  end



  private

  def check_author?
    unless current_user.is_author?(@answer)
      redirect_to @answer.question, alert: 'You are not author of this answer'
    end
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

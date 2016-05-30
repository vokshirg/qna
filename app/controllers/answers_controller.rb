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
    render :new unless @answer.save
  end

  def edit
    @answer.attachments.build
  end

  def update
    render :edit unless @answer.update(answer_params)
  end

  def destroy
    @answer.destroy
  end

  def right_answer
    unless @answer.is_right_answer(current_user)
      render status: 403
    end
  end

  def not_right_answer
    if @answer.not_right_answer(current_user)
      render :right_answer
    else
      render nothing: true, status: 403
    end
  end



  private

  def check_author?
    unless current_user.is_author?(@answer)
      redirect_to @answer.question, alert: 'You are not author of this answer'
    end
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file, :id, :_destroy])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show ]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :is_author?, only: [:edit, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.build
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      redirect_to @question, notice: "Your question successfully created"
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: "Question was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def is_author?
    unless current_user.is_author?(@question)
      redirect_to @question, alert: 'You are not author of this question'
    end
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show ]
  before_action :is_author?, only: [:edit, :destroy]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question
      flash[:notice] = "Your question successfully created"
    else
      render :new
    end
  end

  def update
      if @question.update(question_params)
        flash[:success] = "Question was successfully updated"
        redirect_to @question
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
    @question = Question.find(params[:id])
    if @question.user != current_user
      flash[:alert] = 'You are not author of this question'
      # render :show
      redirect_to questions_path
    end
  end

  def question_params
    params.require(:question).permit(:title, :body, :user_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end

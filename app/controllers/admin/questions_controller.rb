class Admin::QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only
  before_action :find_test, only: [:index,:new, :create]
  before_action :find_question, only: [:show,:edit, :update, :destroy]

  def index
    @questions = @test.questions
  end

  def show
    redirect_to admin_question_answers_path(@question)
  end
  def new
    @question = @test.questions.new
  end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to admin_test_path(@test), notice: 'Question was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to admin_test_path(@question.test), notice: 'Question was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    redirect_to admin_test_path(@question.test), notice: 'Question was successfully destroyed.'
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

end

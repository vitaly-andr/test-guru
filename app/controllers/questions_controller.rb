class QuestionsController < ApplicationController
  before_action :find_test, only: [:index, :new, :create]
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :find_test_for_question, only: [:edit, :update, :destroy]


  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
  end

  def new
    @question = @test.questions.new
  end

  def create
    @question = @test.questions.build(question_params)
    if @question.save
      redirect_to test_questions_path(@test), notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def show
    render plain: @question.body
  end

  def edit
    # @question is already loaded by find_question
  end

  def update
    if @question.update(question_params)
      redirect_to test_questions_path(@question.test), notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to test_questions_path(@question.test), notice: 'Question was successfully deleted.'
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_test_for_question
    @test = @question.test
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

  def rescue_with_question_not_found
    render plain: 'Question was not found', status: 404
  end
end

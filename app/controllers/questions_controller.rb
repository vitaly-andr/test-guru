class QuestionsController < ApplicationController
  before_action :find_test, only: [:index]
  before_action :find_question, only: [:show]


  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
  end


  def show
    render plain: @question.body
  end


  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def rescue_with_question_not_found
    render plain: 'Question was not found', status: 404
  end
end

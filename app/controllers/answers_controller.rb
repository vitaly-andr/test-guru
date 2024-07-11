class AnswersController < ApplicationController
  before_action :find_question, only: [:index]
  before_action :find_answer, only: [:show]
  def index
    @answers = @question.answers
  end

  def show
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end
  def find_answer
    @answer = Answer.find(params[:id])
  end

end

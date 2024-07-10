class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: [:index, :new, :create]
  before_action :find_answer, only: [:show, :edit, :update, :destroy]
  def index
    @answers = @question.answers
  end

  def show
  end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.build(answer_params)
    if @answer.save
      redirect_to question_answers_path(@question), notice: 'Answer was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @answer.update(answer_params)
      redirect_to question_answers_path(@answer.question), notice: 'Answer was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_answers_path(@answer.question), notice: 'Answer was successfully deleted.'
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end
  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :correct)
  end
end

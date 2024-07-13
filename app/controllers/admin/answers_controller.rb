class Admin::AnswersController < Admin::AdminController
  before_action :set_question, only: [:index, :new, :create]
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  def index
    @answers = @question.answers
  end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to admin_question_path(@question), notice: t('shared.flash.created.answer')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @answer.update(answer_params)
      redirect_to admin_question_path(@answer.question), notice: t('shared.flash.updated.answer')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @answer.destroy
    redirect_to admin_question_path(@answer.question), notice: t('shared.flash.deleted.answer')
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :correct)
  end
end

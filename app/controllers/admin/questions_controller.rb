class Admin::QuestionsController < Admin::AdminController
  before_action :find_test, only: [:index, :new, :create]
  before_action :find_question, only: [:show, :edit, :update, :destroy]

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
      redirect_to admin_test_path(@test), notice: t('helpers.submit.question.create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to admin_test_path(@question.test), notice: t('helpers.submit.question.update')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    redirect_to admin_test_path(@question.test), notice: t('helpers.submit.question.destroy')
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

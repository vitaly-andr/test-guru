class Admin::TestsController < Admin::AdminController
  before_action :set_test, only: %i[show edit update destroy]


  def index
    @tests = Test.all
  end

  def show
    redirect_to admin_test_questions_path(@test)
  end

  def new
    @test = Test.new
  end

  def create
    @test = current_user.authored_tests.new(test_params)
    if @test.save
      redirect_to admin_tests_path, notice: t('helpers.submit.test.create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @test.update(test_params)
      redirect_to admin_tests_path, notice: t('helpers.submit.test.update')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path, notice: t('shared.flash.deleted.test')
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

end

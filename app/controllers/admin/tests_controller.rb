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
      redirect_to admin_tests_path, notice: t('shared.flash.created.test')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @test.update(test_params)
      # redirect_to admin_test_path(@test), notice: t('shared.flash.updated.test')
      # render partial: 'admin/tests/test', locals: { test: @test }, notice: t('shared.flash.updated.test')
      render(@test)
    else
      flash[:error] = @test.errors.full_messages.join(", ")
      @tests = Test.all
      render :index, status: :unprocessable_entity
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
    params.require(:test).permit(:title, :level, :category_id, :published, :author_id, :timer)
  end

end

class TestsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test, only: %i[show edit update destroy start]
  before_action :set_user, only: :start

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all
  end

  def show
    redirect_to test_questions_path(@test)
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)
    if @test.save
      redirect_to tests_path, notice: 'Test was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    if @test.update(test_params)
      redirect_to tests_path, notice: 'Test was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_path, notice: 'Test was successfully deleted.'
  end

  def start
    current_user.tests.push(@test)
    redirect_to @user.test_passage(@test)
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end
  def set_user
    @user = User.first
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :author_id)
  end

  def rescue_with_test_not_found
    render plain: 'Test was not found', status: 404
  end
end

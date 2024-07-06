class UserTestsController < ApplicationController
  before_action :find_user_test, only: [:show, :edit, :update, :destroy]

  def index
    @user_tests = UserTest.all
  end

  def show
  end

  def new
    @user_test = UserTest.new
  end

  def create
    @user_test = UserTest.new(user_test_params)
    if @user_test.save
      redirect_to user_tests_path, notice: 'User Test was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user_test.update(user_test_params)
      redirect_to user_tests_path, notice: 'User Test was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user_test.destroy
    redirect_to user_tests_path, notice: 'User Test was successfully deleted.'
  end

  private

  def find_user_test
    @user_test = UserTest.find(params[:id])
  end

  def user_test_params
    params.require(:user_test).permit(:user_id, :test_id, :status)
  end
end

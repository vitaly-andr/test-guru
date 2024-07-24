class TestsController < ApplicationController
  before_action :set_test, only: [:start]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all
  end

  def start
    current_user.tests.push(@test)
    # current_user.tests.push(@test) добавляет тест к пользователю.
    # Это вызывает создание TestPassage через ассоциацию has_many :through.

    redirect_to current_user.test_passage(@test)
  rescue ActiveRecord::RecordInvalid => e
    flash[:error] = e.record.errors.full_messages.join(", ")
    redirect_to tests_path

  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def rescue_with_test_not_found
    render plain: t('errors.messages.test_not_found'), status: 404
  end
end

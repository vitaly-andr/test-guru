class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result]

  def show
    puts "show - #{@test_passage.current_question.inspect}"
    finish_test_passage if time_over?

  end

  def result
    @awarded_badges = @test_passage.user.user_badges.includes(:badge).map(&:badge)
  end

  def update
    if params[:answer_ids].nil?
      flash[:alert] = t(".errors.empty_answer_ids")
      render :show, status: :unprocessable_entity
      return
    end

    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed? || time_over?
      finish_test_passage
    else
      render :show
    end
    end



  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def time_over?
    return false unless @test_passage.test.timer

    # Преобразуем минуты в секунды
    max_time = @test_passage.test.timer * 60
    elapsed_time = Time.current - @test_passage.created_at

    elapsed_time > max_time
  end

  def finish_test_passage
    @test_passage.passed = @test_passage.success?
    if @test_passage.save
      process_badges
      redirect_to result_test_passage_path(@test_passage)
    else
      flash.now[:alert] = @test_passage.errors.full_messages.join(", ")
      render :show, status: :unprocessable_entity
    end
  end
  def process_badges
    badge_service = BadgeService.new(@test_passage)

    badge_service.call do |badge, result|
      case result
      when :award_badge
        flash[:notice] ||= []
        flash[:notice] << t("test_passages.update.badge_awarded", badge: badge.title)
      when :confirm_badge
        flash[:notice] ||= []
        flash[:notice] << t("test_passages.update.confirm_badge", badge: badge.title)
        new_tests = badge_service.new_tests_to_complete(badge)
        flash[:info] ||= []
        flash[:info] << t("test_passages.update.new_tests_to_complete", tests: new_tests.map(&:title).join(", "))
      else
        flash[:alert] ||= []
        flash[:alert] << t("test_passages.update.unknown_badge_state", badge: badge.title)
      end
    end
  end
end

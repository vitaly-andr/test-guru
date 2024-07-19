class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result]

  def show
    puts "show - #{@test_passage.current_question.inspect}"
  end

  def result

  end

  def update
    if params[:answer_ids].nil?
      flash[:alert] = t(".errors.empty_answer_ids")
      render :show
    else
      @test_passage.accept!(params[:answer_ids])

      if @test_passage.completed?
        redirect_to result_test_passage_path(@test_passage)
      else
        render :show
      end
    end
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end

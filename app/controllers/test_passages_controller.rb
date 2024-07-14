class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]

  def show
    puts "show - #{@test_passage.current_question.inspect}"
  end
  def result

  end
  def update
    @test_passage.accept!(params[:answer_ids])
    if @test_passage.completed?
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist

    client = params[:client]
    service = GistQuestionService.new(@test_passage.current_question, client: client)
    result = service.call

    flash_options = if result[:success]
                      { notice: t('.success', url: result[:html_url]).html_safe }
                    else
                      { alert: t('.failure')}
                    end

    redirect_to @test_passage, flash_options
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end

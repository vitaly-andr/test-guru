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

    if result[:success]
      Gist.create!(question: @test_passage.current_question, user: current_user, url: result[:html_url])
      link = view_context.link_to(t('.view_gist'), result[:html_url], target: '_blank')
      flash_message = t('.success', link: link)
      flash[:notice] = flash_message
    else
      flash_message = t('.failure')
      flash[:alert] = flash_message
    end

    redirect_to @test_passage
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end

class GistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[create]

  def create
    client = params[:client]
    service = GistQuestionService.new(@test_passage.current_question, client: client)
    result = service.call

    if service.success?
      begin
        Gist.create!(question: @test_passage.current_question, user: current_user, url: result)
        link = view_context.link_to(t('.view_gist'), result, target: '_blank')
        flash_message = t('.success', link: link)
        flash[:notice] = flash_message
      rescue ActiveRecord::RecordInvalid => e
        flash_message = t('.database_error', message: e.message)
        flash[:alert] = flash_message
      end
      link = view_context.link_to(t('.view_gist'), result, target: '_blank')
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
    @test_passage = TestPassage.find(params[:test_passage_id])
  end
end

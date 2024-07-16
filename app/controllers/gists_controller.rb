class GistsController < ApplicationController
  before_action :set_test_passage, only: %i[create]

  def create
    client = params[:client]
    service = GistQuestionService.new(@test_passage.current_question, client: client)
    result = service.call

    result.when_success do
      begin
        Gist.create!(question: @test_passage.current_question, user: current_user, url: result.url)
        link = view_context.link_to(t('.view_gist'), result.url, target: '_blank')
        flash[:notice] = t('.success', link: link)
      rescue ActiveRecord::RecordInvalid => e
        flash[:alert] = t('.database_error', message: e.message)
      end
    end

    result.when_error do |error_message|
      flash[:alert] = t('.failure') + ": #{error_message}"
    end

    redirect_to @test_passage
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:test_passage_id])
  end
end

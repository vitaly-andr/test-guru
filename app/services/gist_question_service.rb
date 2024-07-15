class GistQuestionService
  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = initialize_client(client)
  end

  def call
    @response = @client.create_gist(gist_params)
    @success = @response[:success]
    @html_url = @response[:html_url] if @success
  end

  def success?
    @success
  end

  private

  def initialize_client(client)
    case client&.to_sym
    when :octokit
      GitHubClientOctokit.new
    else
      GitHubClientFaraday.new
    end
  end

  def gist_params
    {
      description: "A question about #{@test.title} from TestGuru",
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end

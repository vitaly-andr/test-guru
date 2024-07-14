class GitHubClientOctokit
  ROOT_ENDPOINT = 'https://api.github.com'

  def initialize
    @access_token = ENV['GITHUB_TOKEN']
    raise 'Access token not found' if @access_token.nil?

    @client = setup_client
  end

  def create_gist(params)
    response = @client.create_gist(params)
    parse_response(response)
  end

  private

  def setup_client
    Octokit::Client.new(access_token: @access_token)
  end

  def parse_response(response)
    if response.id
      { success: true, html_url: response.html_url }
    else
      { success: false }
    end
  end
end

class GitHubClientOctokit
  ACCESS_TOKEN = ENV['GITHUB_GIST_TOKEN']

  def initialize
    @access_token = ACCESS_TOKEN
    raise 'Access token not found' if @access_token.nil?

    @client = setup_client
  end

  def create_gist(params)
    response = @client.create_gist(params)
    html_url = response.html_url if success?
    GistService::GithubGist.new(html_url, success?)
  rescue Octokit::Error => e
    GistService::GithubGist.new(nil, false, e.message)
  end

  def success?
    @client.last_response.status == 201
  end

  private

  def setup_client
    Octokit::Client.new(access_token: @access_token)
  end
end

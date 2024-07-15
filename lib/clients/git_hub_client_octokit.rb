class GitHubClientOctokit
  ACCESS_TOKEN = ENV['GITHUB_GIST_TOKEN']

  def initialize
    @access_token = ACCESS_TOKEN
    raise 'Access token not found' if @access_token.nil?

    @client = setup_client
  end

  def create_gist(params)
    begin
      response = @client.create_gist(params)
      { success: true, html_url: response.url }
    rescue Octokit::Error => e
      puts "An error occurred: #{e.message}"
      { success: false }
    end
  end

  private

  def setup_client
    Octokit::Client.new(access_token: @access_token)
  end

end

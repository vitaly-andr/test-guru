class GitHubClientFaraday
  ROOT_ENDPOINT = 'https://api.github.com'
  ACCESS_TOKEN = ENV['GITHUB_GIST_TOKEN']

  def initialize
    @access_token = ACCESS_TOKEN
    raise 'Access token not found' if @access_token.nil?

    @http_client = setup_http_client
  end

  def create_gist(params)
    response = @http_client.post('gists') do |request|
      request.headers['Authorization'] = "token #{@access_token}"
      request.headers['Content-Type'] = 'application/json'
      request.body = params.to_json
    end
    parse_response(response)
  rescue Faraday::Error => e
    GistService::GithubGist.new(nil, false, e.message)
  end

  def success?
    @http_client.last_response.status == 201
  end

  private

  def setup_http_client
    Faraday.new(url: ROOT_ENDPOINT)
  end

  def parse_response(response)
    success = response.status == 201
    html_url = JSON.parse(response.body)["html_url"] if success
    GistService::GithubGist.new(html_url, success)
  end
end

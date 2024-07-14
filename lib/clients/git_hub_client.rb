class GitHubClient
  ROOT_ENDPOINT = 'https://api.github.com'

  def initialize
    @access_token = Rails.application.credentials.dig(:github, :access_token)
    raise 'Access token not found' if @access_token.nil?

    @http_client = setup_http_client
  end

  def create_gist(params)
    puts "Using access token: #{@access_token}" # Дополнительный вывод токена
    response = @http_client.post('gists') do |request|
      request.headers['Authorization'] = "token #{@access_token}"
      request.headers['Content-Type'] = 'application/json'
      request.body = params.to_json
    end
  end

  private

  def setup_http_client
    Faraday.new(url: ROOT_ENDPOINT)
  end

end

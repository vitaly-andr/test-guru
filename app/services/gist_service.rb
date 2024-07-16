require 'singleton'

class GistService
  include Singleton

  GithubGist = Struct.new(:url, :success, :error) do
    def when_success
      yield self if success
    end

    def when_error
      yield error unless success
    end
  end
end

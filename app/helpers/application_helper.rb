module ApplicationHelper
  def form_header(resource)
    model_name = resource.model_name.human.downcase
    action = resource.new_record? ? 'Create new' : 'Edit'
    "#{action} #{model_name}"
  end
end
def current_year
  Time.now.year
end

def github_url(author, repo)
  "https://github.com/#{author}/#{repo}"
end

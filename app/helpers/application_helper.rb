module ApplicationHelper
  def form_header(resource)
    model_name = resource.model_name.human.downcase
    action = resource.new_record? ? t('actions.create') : t('actions.edit')
    "#{action} #{model_name}"
  end

  def current_year
    Time.now.year
  end

  def github_url(author, repo, link_text = nil)
    link_text ||= "#{author}/#{repo}"
    link_to link_text, "https://github.com/#{author}/#{repo}", target: '_blank'
  end

end

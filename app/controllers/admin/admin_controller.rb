class Admin::AdminController < ApplicationController
  before_action :admin_only

  private

  def admin_only
    unless current_user.admin?
      flash[:alert] = t('errors.messages.access_denied')
      redirect_to root_path
    end
  end
end

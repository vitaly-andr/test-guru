class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new

  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_back_or_to tests_path
    else
      flash.now[:alert] = 'Are you a Guru? Verify your Email and Password please'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out!'
  end
  private

  def redirect_back_or_to(default)
    redirect_to(cookies[:return_to] || default)
    cookies.delete(:return_to)
  end
end



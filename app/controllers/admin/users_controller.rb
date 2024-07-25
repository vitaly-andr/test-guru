class Admin::UsersController < Admin::AdminController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    user_params_without_confirmation = user_params.except(:skip_confirmation)
    @user = User.new(user_params_without_confirmation)

    if params[:user][:skip_confirmation] == '1'
      @user.skip_confirmation_notification!
      @user.confirmed_at = Time.current
    end

    if @user.save
      redirect_to admin_users_path, notice: t('shared.flash.created.user')
    else
      render :new, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    flash[:error] = e.record.errors.full_messages.join(", ")
    render :new, status: :unprocessable_entity
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])

    user_params_without_password = user_params
    user_params_without_password.delete(:password) if user_params[:password].blank?
    user_params_without_password.delete(:password_confirmation) if user_params[:password_confirmation].blank?

    if @user.update(user_params_without_password)
      redirect_to admin_users_path, notice: t('shared.flash.updated.user')
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully destroyed.'
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin, :skip_confirmation)
  end
end

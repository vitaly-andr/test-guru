class Admin::BadgesController < ApplicationController
  before_action :set_badge, only: %i[show edit update destroy]

  def index
    @badges = Badge.all
  end

  def new
    @badge = Badge.new
  end
  def show

  end
  def create
    @badge = Badge.new(badge_params)
    if @badge.save
      redirect_to admin_badges_path, notice: I18n.t('admin.badges.created')
    else
      flash.now[:alert] = @badge.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @badge.update(badge_params)
      render(@badge)
    else
      flash[:error] = @test.errors.full_messages.join(", ")
      @badges = Badge.all
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path, notice: I18n.t('admin.badges.deleted')
  end

  private

  def set_badge
    @badge = Badge.find(params[:id])
  end

  def badge_params
    params.require(:badge).permit(:title, :image, :rule, :rule_value, :description)
  end
end

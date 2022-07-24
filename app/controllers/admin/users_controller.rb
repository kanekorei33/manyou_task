class Admin::UsersController < ApplicationController
before_action :set_user, only: %i[ show edit update destroy ]
before_action :require_admin

  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_user_path(@user), notice: "アドミンユーザーを登録しました"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "アドミンユーザー情報を更新しました"
    end
  end

  def destroy
    @user = user.find(params[:id])
    @user.destroy
    redirect_to admin_user_path, notice: "アドミンユーザーを消去しました"
  end

  private

  def require_admin
    redirect_to root_path unless current_user.admin?
    flash[:notice] = "管理者以外アクセスできません"
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def user_logged_in?
    !current_user.nil? && current_user.admin?
    end
end

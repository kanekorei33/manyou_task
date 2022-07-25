class Admin::UsersController < ApplicationController
before_action :require_admin
before_action :set_user, only: %i[ show edit update destroy ]


  def index
#binding.pry
    @users = User.all.includes(:tasks)
  end

  def new
#binding.pry
    @user = User.new
  end

  def create
   # binding.pry
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_user_path(@user), notice: "ユーザー#{@user.name}を登録しました"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
   #binding.pry
  end

  def show
  #  binding.pry
    @user = User.find(params[:id])
  end

  def update
 #   binding.pry
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー#{@user.name}情報を更新しました"
    else
      redirect_to edit_admin_user_path(@user), notice: "管理者がいなくなるためユーザー#{@user.name}情報を更新できません"
    end
  end

  def destroy
 #   binding.pry
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザー#{@user.name}を消去しました"
    else
      redirect_to admin_users_path, notice:"管理者がいなくなるため#{@user.name}を消去できません"
    end
  end

  private

  def require_admin
    unless current_user.admin?
    redirect_to tasks_path,
    notice: '管理者以外はアクセスできません'
    end
  end

  def set_user
#binding.pry
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

end

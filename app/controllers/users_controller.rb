class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]
  before_action :admin_user, only: %i[ destroy ]#アクション前に事前確認用。
  skip_before_action :login_required, only: %i[ new create ]
  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    redirect_to tasks_path unless params[:id] == current_user.id.to_s
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  # GET /users/new
  def new
    redirect_to tasks_path if logged_in?
    flash[:notice] = "すでにあなたはログインしてます"
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to tasks_path
    end
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "ユーザー登録しました"
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = "ユーザー登録に失敗しました"
      render :new
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
    User.find(params[:id]).destroy
    flash[:success] = "ユーザー削除完了"
    redirect_to users_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :task_id)
  end

  #管理者か確認。
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end

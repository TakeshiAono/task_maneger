class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :admin?

  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def edit
    @user = User.find(params[:id])
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path(@user)}
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
      format.html { redirect_to admin_users_path}
      format.json { head :no_content }
    end
  end

  private
  def admin?
    redirect_to tasks_path, notice: "管理者以外はアクセスできません" unless User.find(session[:user_id]).admin == true
  end

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password_digest, :image, :section, :password, :password_confirmation)
  end

  def if_not_admin
    redirect_to root_path unless current_user.id?
  end
end

class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:login, :create, :destroy]
  def new
  end
  
  def login
    @user = User.new
  end
  

  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :login
    end
  end

  def destroy
      session.delete(:user_id)
      flash[:notice] = 'ログアウトしました'
      redirect_to login_sessions_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password)
    end
end

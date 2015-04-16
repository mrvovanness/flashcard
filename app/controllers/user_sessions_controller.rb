class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:success] = t(:user_action_success, action: "entered")
      redirect_to root_path
    else
      flash[:danger] = t(:user_action_error, action: "correct")
      render "new"
    end
  end

  def destroy
    logout
    flash[:info] = t(:logout_alert)
    redirect_to login_path
  end
end

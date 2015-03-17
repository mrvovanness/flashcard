class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:success] = "Добро пожаловать!"
      redirect_to root_path
    else
      flash[:danger] = "Попробуй еще раз или зарегистируйся!"
      render "new"
    end
  end

  def destroy
    logout
    flash[:info] = "Вы вышли!"
    redirect_to login_path
  end
end

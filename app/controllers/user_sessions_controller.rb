class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(user_params[:email], user_params[:password])
      flash[:success] = t('user.success',
                          action: t('action.enter'))
      redirect_to root_path
    else
      flash[:danger] = t('user.error',
                         action: t('action.correct'))
      redirect_to :back
    end
  end

  def destroy
    logout
    flash[:info] = t('user.logout')
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

class UserRegistrationController < ApplicationController
  skip_before_action :require_login

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t('user.success',
                          action: t('action.save'))
      auto_login(@user)
      redirect_to root_path
    else
      flash[:warning] = t('user.error',
                          action: t('action.save'))
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

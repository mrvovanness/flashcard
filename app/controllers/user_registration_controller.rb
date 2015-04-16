class UserRegistrationController < ApplicationController
  skip_before_action :require_login

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t(:user_action_success, action: "saved")
      auto_login(@user)
      redirect_to root_path
    else
      flash[:warning] = t(:user_action_error, action: "saved")
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

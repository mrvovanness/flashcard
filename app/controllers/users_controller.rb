class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Вы зарегистированы"
      auto_login(@user)
      redirect_to root_path
    else
      flash[:warning] = "Вы не зарегистрированы, попробуйте еще раз"
      render "new"
    end
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = "Вы изменили свои данные"
      redirect_to root_path
    else
      flash[:warning] = "Данные не обновлены!"
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

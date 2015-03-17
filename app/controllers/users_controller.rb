class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]

  def index
  end

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
      render 'index'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Вы изменили свои данные"
      redirect_to root_path
    else
      flash[:warning] = "Данные не обновлены!"
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

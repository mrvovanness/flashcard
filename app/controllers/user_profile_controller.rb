class UserProfileController < ApplicationController
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

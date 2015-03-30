class UserProfileController < ApplicationController
  def edit
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

  def set_current_deck
    current_user.update_attributes(current_deck_id: params[:deck_id])
    if params[:deck_id] == nil
      flash[:success] = "Текущая колода не установлена"
    else
    flash[:success] = "Текущая колода #{current_user.current_deck.name}"
    end
    redirect_to root_path
  end
   
  private

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :current_deck_id
    )
  end
end

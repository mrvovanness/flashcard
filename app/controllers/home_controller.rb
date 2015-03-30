class HomeController < ApplicationController
  def index
    if current_user.current_deck.present?
      @card = current_user.current_deck.cards.pending.first
    else
      @card = current_user.cards.pending.first
    end
  end

  def check_card
    @card = Card.find(check_params[:card_id])
    if @card.check_translation(check_params[:user_translation])
      flash[:success] = "Правильно"
    else
      flash[:warning] =
        "Неправильно! Правильный ответ был #{@card.original_text}"
    end
    redirect_to root_path
  end
  
  private

  def check_params
    params.permit(:card_id, :user_translation)
  end
end

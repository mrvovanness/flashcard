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
    results = @card.check_translation(check_params[:user_translation])
    case results[:typos_count]
    when 0 then
      flash[:success] = "Правильно"
    when 1, 2 then
      flash[:warning] = "Возможно, произошла опечатка<br>
      Правильный ответ #{@card.original_text}<br>
      Вы ввели #{params[:user_translation]}"
    else
      flash[:warning] = "Неправильно! Правильный ответ был #{@card.original_text}"
    end
    redirect_to root_path
  end
  
  private

  def check_params
    params.permit(:card_id, :user_translation)
  end
end

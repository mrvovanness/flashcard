class HomeController < ApplicationController
  def index
    @card = Card.pending.first
  end

  def check_card
    @card = Card.find(check_params)
    if @card.check_translation(params[:original_text])
      flash[:success] = "Правильно"
    else
      flash[:warning] = "Неправильно! Правильный ответ был #{@card.original_text}"
    end
    redirect_to root_path
  end
  
  private

  def check_params
    params.require(:card_id)
  end
end

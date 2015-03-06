class HomeController < ApplicationController
  
  def index
    @card = Card.pending.sample
  end

  def check_card
    @card = Card.find(params[:id])
    if @card.check_translation(params[:original_text]) == true
      @card.update(card_params)
      flash[:success] = "Правильно"
      redirect_to root_path
    else
      flash[:error] = "Неправильно"
      redirect_to root_path
    end
  end

  private

  def card_params
    params.permit(:original_text, :translated_text)
  end
end

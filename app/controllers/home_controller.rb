class HomeController < ApplicationController
  def index
    @card = Card.pending.sample
  end

  def check_card
    @card = Card.find(params[:id])
    if @card.check_translation(params[:original_text])
      flash[:success] = "Правильно"
    else
      flash[:warning] = "Неправильно"
    end
      redirect_to root_path
  end
end

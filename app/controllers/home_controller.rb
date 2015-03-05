class HomeController < ApplicationController
  before_action :card_sample, only: [:index, :success, :error]
  
  def index
  end

  def checking
    @card = Card.find(params[:id])
    if @card.check(params[:original_text]) == true
      @card.update(params.permit(:original_text, :translated_text))
      redirect_to '/success'
    else
      redirect_to '/error'
    end
  end
 
  def success
  end

  def error
  end

  private
  def card_sample
    @card = Card.review_cards.sample
  end
end

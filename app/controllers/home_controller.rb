class HomeController < ApplicationController
  before_action :set_card_for_review

  def index
  end

  def check_card
    card = Card.find(check_params[:card_id])
    result = card.check_translation(check_params[:user_translation],
                                     check_params[:response_time])
    respond_to do |format|
      case result[:assession_mark]
      when 5 then
        flash[:success] = t('card.check_success')
        format.js
      when 4, 3 then
        flash[:warning] = t('card.check_delay')
        format.js
      when 2 then
        flash[:warning] = t('card.typos',
                            correct_answer: @card.original_text,
                            typed_word: check_params[:user_translation])
        format.js
      else
        flash[:warning] = t('card.check_error',
                            right_card: @card.original_text)
       format.js
      end
    end
  end
  
  private

  def set_card_for_review
    if current_user.current_deck.present?
      @card = current_user.current_deck.cards.pending.first
    else
      @card = current_user.cards.pending.first
    end
  end

  def check_params
    params.require(:check_data).permit(:card_id,
                                       :user_translation,
                                       :response_time)
  end
end

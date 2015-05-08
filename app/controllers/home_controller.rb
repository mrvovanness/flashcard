class HomeController < ApplicationController
  def index
    if current_user.current_deck.present?
      @card = current_user.current_deck.cards.pending.first
    else
      @card = current_user.cards.pending.first
    end
  end

  def check_card
    card = Card.find(check_params[:card_id])
    result = card.check_translation(check_params[:user_translation],
                                    check_params[:response_time].to_i)
    @response_alert = {}
    respond_to do |format|
      case result[:assession_mark]
      when 5 then
        @response_alert[:success] = t('card.check_success')
      when 4, 3 then
        @response_alert[:info] = t('card.check_delay')
      when 2 then
        @response_alert[:warning] = t('card.typos',
                                      correct_answer: card.original_text,
                                      typed_word: check_params[:user_translation])
      else
        @response_alert[:danger] = t('card.check_error',
                                      right_card: card.original_text)
      end
      format.json
    end
  end

  private

  def check_params
    params.require(
      :check_data).permit(
        :card_id, :user_translation, :response_time)
  end
end

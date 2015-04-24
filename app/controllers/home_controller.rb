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
    result = @card.check_translation(check_params[:user_translation])
    case result[:typos_count]
    when 0 then
      flash[:success] = t('card.check_success')
    when 1, 2 then
      flash[:warning] = t('card.typos',
                          name_of_right_card: @card.original_text,
                          typed_word: check_params[:user_translation])
    else
      flash[:warning] = t('card.check_error',
                          right_card: @card.original_text)
    end
    redirect_to root_path
  end
  
  private

  def check_params
    params.require(:check_data).permit(:card_id, :user_translation)
  end
end

class CardsController < ApplicationController
  before_action :find_card, only:  [:show, :edit, :update, :destroy]

  def index
    @cards = current_user.cards.all
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = current_user.cards.new(card_params)
    if @card.save
      flash[:info] = t('card.success',
                       action: t('action.create'),
                       deck: @card.deck.name)
      redirect_to @card
    else
      flash[:danger] = t('card.error')
      render "new"
    end
  end

  def update
    if @card.update(card_params)
      flash[:info] = t('card.success',
                       action: t('action.update'),
                       deck: @card.deck.name)
      redirect_to @card
    else
      flash[:danger] = t('card.error')
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private

  def card_params
    parameters = params.require(:card).permit(
      :original_text, :translated_text, :picture, :picture_cache,
      :remote_picture_url, :remove_picture, :deck_id)
    if params[:new_deck_name].present?
      new_deck = current_user.decks.create(name: params[:new_deck_name])
      parameters.merge!(deck_id: new_deck.id)
    else
      parameters
    end
  end

  def find_card
    @card = current_user.cards.find(params[:id])
  end
end

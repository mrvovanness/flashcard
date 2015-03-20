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
      redirect_to @card
    else
      render 'new'
    end
  end

  def update
    if @card.update(card_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :card_picture, :card_picture_cache, :remote_card_picture_url, :remove_card_picture)
  end

  def find_card
    @card = current_user.cards.find(params[:id])
  end
end

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
    @card = current_user.decks.find(card_params[:deck_id]).cards.new(card_params)
    if @card.save
      flash[:info] = "Ты создал новую карточку"
      redirect_to @card
    else
      flash[:danger] = "Что-то пошло не так. Попробуй еще раз!"
      render "new"
    end
  end

  def update
    if @card.update(card_params)
      flash[:info] = "Ты обновил карточку"
      redirect_to @card
    else
      flash[:danger] = "Что-то пошло не так. Попробуй еще раз!"
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :picture, :picture_cache, :remote_picture_url, :remove_picture, :deck_id, :name)
  end

  def find_card
    @card = current_user.cards.find(params[:id])
  end
end

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
    parameters = card_params
    @card = current_user.cards.new(parameters)
    if params[:new_deck_name].present?
      new_deck = current_user.decks.create(name: params[:new_deck_name])
      parameters.merge!(deck_id: new_deck.id)
    end
    if @card.save
      flash[:info] = 
        "Ты создал новую карточку в колоде #{current_user.decks.find(@card.deck_id).name}"
      redirect_to @card
    else
      flash[:danger] = "Что-то пошло не так. Попробуй еще раз!"
      render "new"
    end
  end

  def update
    parameters = card_params
    if params[:new_deck_name].present?
      new_deck = current_user.decks.create(name: params[:new_deck_name])
      parameters.merge!(deck_id: new_deck.id)
    end
    if @card.update(parameters)
      flash[:info] = "Ты обновил карточку в колоде \
      #{current_user.decks.find(@card.deck_id).name}"
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
    params.require(:card).permit(:original_text, :translated_text, :picture, :picture_cache, :remote_picture_url, :remove_picture, :deck_id)
  end

  def find_card
    @card = current_user.cards.find(params[:id])
  end
end

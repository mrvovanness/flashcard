class DecksController < ApplicationController
  before_action :find_deck, only: [:show, :edit, :update, :destroy]
  def index
    @decks = current_user.decks.all
  end

  def show
  end

  def new
    @deck = Deck.new
  end

  def edit
  end

  def create
    @deck = current_user.decks.new(deck_params)
    if @deck.save
      flash[:info] = "Ты создал новую колоду"
      redirect_to @deck
    else
      flash[:danger] = "Попробуй еще раз"
      render "new"
    end
  end

  def update
    if @deck.update(deck_params)
      flash[:info] = "Ты изменил колоду"
      redirect_to @deck
    else
      flash[:danger] = "Попробуй еще раз"
      render "edit"
    end
  end

  def destroy
    @deck.destroy
    redirect_to decks_paths
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :user_id)
  end

  def find_deck
    @deck = current_user.decks.find(params[:id])
  end
end

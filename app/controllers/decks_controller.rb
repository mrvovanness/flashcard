class DecksController < ApplicationController
  def index
    @decks = current_user.decks.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def deck_params
    params.require(:deck).permit(:name)
  end

  def find_deck
    @deck = current_user.decks.find(params[:id])
  end
end

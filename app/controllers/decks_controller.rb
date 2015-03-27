class DecksController < ApplicationController
  def index
    @decks = current_user.decks.all
  end

  def show
  end


  def edit
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

class LocalesController < ApplicationController
  skip_before_action :require_login

  def update
    session[:locale] = params[:locale]
    redirect_to :back
  end
end

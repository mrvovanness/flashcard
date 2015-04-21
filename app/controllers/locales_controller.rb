class LocalesController < ApplicationController
  skip_before_action :require_login

  def update
    redirect_to :back
  end
end

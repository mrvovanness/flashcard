class LocalesController < ApplicationController
  skip_before_action :require_login, :set_locale

  def update
  end
end

class PlayersController < ApplicationController
  def index
    @players = User.where.not(id: Current.user).order(:email_address)
  end
end

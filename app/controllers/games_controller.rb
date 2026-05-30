class GamesController < ApplicationController
  before_action :set_game, only: %i[ show update destroy ]

  def index
    @games = Game.where(challenger: Current.user).or(Game.where(opponent: Current.user)).order(created_at: :desc)
  end

  def show
  end

  def create
    @game = Game.new(challenger: Current.user, opponent_id: params[:opponent_id], status: :invited)

    if @game.save
      redirect_to @game, notice: "Game invitation sent."
    else
      redirect_to players_path, alert: "Could not create game."
    end
  end

  def update
    if @game.update(game_params)
      redirect_to @game
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @game.soft_delete
    redirect_to games_path, notice: "Game removed."
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.expect(game: [ :status ])
  end
end

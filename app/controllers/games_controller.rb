class GamesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    @game = Game.new(game_params)
    if Player.exists?(name: @game.winner) && Player.exists?(name: @game.loser)
      @game.save
      render json: @game, status: :created, location: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(:winner, :loser)
  end
end

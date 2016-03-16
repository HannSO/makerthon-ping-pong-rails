class PlayersController < ApplicationController

  def index
    players = Player.all
    list = JSON.parse(players)
    p list
  end

  def show

  end

end

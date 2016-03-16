class PlayersController < ApplicationController

  def index
    @player = render json: Player.select('name')
  end

  def show
    # api = RestClient.get(https://slack.com/api/usersdw.list)
  end
end

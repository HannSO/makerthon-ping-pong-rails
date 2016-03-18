class PlayersController < ApplicationController

  def index
    @player = render json: Player.all.order(:win_percentage).reverse_order
  end

end

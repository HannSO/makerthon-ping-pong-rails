class Game < ActiveRecord::Base
  has_many :players
  after_save :update_player

  def update_player
    Player.update_results(winner, loser)
  end

end

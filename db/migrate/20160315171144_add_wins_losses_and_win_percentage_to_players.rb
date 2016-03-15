class AddWinsLossesAndWinPercentageToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :wins, :integer
    add_column :players, :losses, :integer
    add_column :players, :win_percentage, :decimal
  end
end

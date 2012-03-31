class AddPlayerTypeToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :goalie, :boolean

  end
end

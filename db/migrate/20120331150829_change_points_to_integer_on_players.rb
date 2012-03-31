class ChangePointsToIntegerOnPlayers < ActiveRecord::Migration
  def change
    remove_column :players, :season_points
    add_column :players, :season_points, :integer
  end
end

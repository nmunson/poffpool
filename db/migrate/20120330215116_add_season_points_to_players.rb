class AddSeasonPointsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :season_points, :string
  end
end

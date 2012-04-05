class RenamePointsColumnPlayers < ActiveRecord::Migration
  def change
    remove_column :players, :points
    add_column :players, :goals, :integer
  end
end

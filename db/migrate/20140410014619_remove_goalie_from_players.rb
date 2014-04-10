class RemoveGoalieFromPlayers < ActiveRecord::Migration
  def up
    remove_column :players, :goalie
  end

  def down
    add_column :players, :goalie, :boolean
  end
end

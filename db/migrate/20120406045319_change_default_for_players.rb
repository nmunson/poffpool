class ChangeDefaultForPlayers < ActiveRecord::Migration
  def up
    change_column_default :players, :goals, 0
    change_column_default :players, :assists, 0
    change_column_default :players, :wins, 0
    change_column_default :players, :shutouts, 0
  end

  def down
  end
end

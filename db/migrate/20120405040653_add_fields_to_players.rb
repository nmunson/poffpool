class AddFieldsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :points, :integer

    add_column :players, :assists, :integer

    add_column :players, :wins, :integer

    add_column :players, :shutouts, :integer

  end
end

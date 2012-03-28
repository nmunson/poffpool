class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|

      t.timestamps
    end
  end
end

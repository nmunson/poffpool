class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :entrant_id
      t.integer :player_id

      t.timestamps
    end
  end
end

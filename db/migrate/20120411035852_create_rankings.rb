class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :entrant_id
      t.integer :rank
      t.datetime :date

      t.timestamps
    end
  end
end

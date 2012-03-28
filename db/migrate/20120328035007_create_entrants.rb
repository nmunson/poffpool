class CreateEntrants < ActiveRecord::Migration
  def change
    create_table :entrants do |t|

      t.timestamps
    end
  end
end

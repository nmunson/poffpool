class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|

      t.timestamps
    end
  end
end

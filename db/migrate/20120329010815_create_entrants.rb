class CreateEntrants < ActiveRecord::Migration
  def change
    create_table :entrants do |t|
      t.string :name
      t.string :email
      t.string :company
      t.boolean :paid

      t.timestamps
    end
  end
end

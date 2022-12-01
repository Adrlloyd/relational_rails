class CreateClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :clubs do |t|
      t.string :name
      t.integer :position
      t.string :city
      t.boolean :previous_winner
      t.timestamps
    end
  end
end

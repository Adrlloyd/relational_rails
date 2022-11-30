class CreateLeagues < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues do |t|
      t.string :name
      t.integer :level
      t.string :country
      t.boolean :relegation
      t.timestamps
    end
  end
end

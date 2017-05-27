class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :name
      t.string :code
      t.integer :owner_id

      t.timestamps
    end
  end
end

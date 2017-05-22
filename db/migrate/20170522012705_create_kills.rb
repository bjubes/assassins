class CreateKills < ActiveRecord::Migration[5.1]
  def change
    create_table :kills do |t|
      t.integer :killer_id
      t.integer :victim_id

      t.timestamps
    end
  end
end

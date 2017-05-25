class CreateKillConfirmations < ActiveRecord::Migration[5.1]
  def change
    create_table :kill_confirmations do |t|
      t.integer :kill_id, null:false, unique:true
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :receiver_accepted
      t.boolean :verdict

      t.timestamps
    end
  end
end

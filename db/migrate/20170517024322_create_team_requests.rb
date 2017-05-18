class CreateTeamRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :team_requests do |t|
      t.integer :sender_id
      t.integer :reciever_id
      t.integer :team_id

      t.timestamps
    end
  end
end
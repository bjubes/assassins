class AddTeamToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :team, index:true 
  end
end

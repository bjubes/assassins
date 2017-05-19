class AddHittimeAndAliveToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :alive, :boolean, default: true
    add_column :teams, :hittime, :datetime, default: nil
  end
end

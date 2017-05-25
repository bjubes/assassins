class AddTargetAndAssassinToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :target_id, :integer
    add_column :teams, :assassin_id, :integer
  end
end

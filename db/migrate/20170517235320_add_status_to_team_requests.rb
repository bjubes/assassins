class AddStatusToTeamRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :team_requests, :status, :integer, null: false, default: 0
  end
end

class AddassmStateToKillConfirmations < ActiveRecord::Migration[5.1]
  def change
    add_column :kill_confirmations, :state, :string
  end
end

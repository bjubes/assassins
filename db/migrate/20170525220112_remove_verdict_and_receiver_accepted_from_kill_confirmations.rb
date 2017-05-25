class RemoveVerdictAndReceiverAcceptedFromKillConfirmations < ActiveRecord::Migration[5.1]
  def change
    remove_columns :kill_confirmations, :verdict
    remove_columns :kill_confirmations, :receiver_accepted
  end
end

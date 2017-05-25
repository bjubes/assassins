class KillConfirmation < ApplicationRecord
  belongs_to :kill
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  def confirmed?
    if self.verdict != nil then return self.verdict end
    !!self.receiver_accepted
  end
end

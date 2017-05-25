class Kill < ApplicationRecord
  belongs_to :killer, class_name: "User"
  belongs_to :victim, class_name: "User"
  
  def to_sentence
    "#{self.killer.username} killed #{self.victim.username} on #{self.created_at.strftime("%A, %B %d, %Y at %l%p")}"
  end
end

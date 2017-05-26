class Kill < ApplicationRecord
  belongs_to :killer, class_name: "User"
  belongs_to :victim, class_name: "User"
  has_one :kill_confirmation

  def to_sentence
    "#{self.killer.username} killed #{self.victim.username} on #{self.kill_time}"
  end

  def kill_time
    self.created_at.strftime("%A, %B %d, %Y at %l%p")
  end

  def confirmed?
    self.kill_confirmation.confirmed?
  end

  def self.confirmed_kills
    Kill.all.select { |kill| kill.confirmed? }
  end

end

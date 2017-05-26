class KillConfirmation < ApplicationRecord
  include AASM
  belongs_to :kill
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

   # define attributes and accessors for both fields
  attr_accessor :killer_id, :victim_id, :creator_is_killer
   aasm({column: :state}) do
    state :sent, initial: true
    state :accepted
    state :disputed
    state :vetoed
    state :overruled

    event :accept do
      transitions from: :sent, to: :accepted
    end
    event :deny do
      transitions from: :sent, to: :disputed
    end
    event :veto do
      transitions to: :vetoed
    end
    event :approve do
      transitions to: :overruled
    end

    end

  def confirmed?
    (self.state == "accepted" || self.state == "overruled") ? true : false
  end


  def self.new_without_kill(params) #killer_id, victim_id, creator_is_killer
    kill = Kill.new
    kill.killer_id = params[:killer_id]
    kill.victim_id = params[:victim_id]
    kill.save!

    KillConfirmation.new_from_kill(kill, params[:creator_is_killer])
  end

  def self.new_from_kill(kill, creator_is_killer=true)
    creator_is_killer = true if creator_is_killer == nil
    kc = KillConfirmation.new
    kc.kill = kill
    kc.sender = kill.killer
    kc.receiver = kill.victim
    if !creator_is_killer
      #swap the sender and receiver
      kc.sender, kc.receiver = kc.receiver, kc.sender
    end
    kc
  end

end

class KillConfirmation < ApplicationRecord
  belongs_to :kill
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

   # define attributes and accessors for both fields
  attr_accessor :killer_id, :victim_id, :creator_is_killer

  
  def confirmed?
    if self.verdict != nil then return self.verdict end
    !!self.receiver_accepted
  end
    
  def self.new_without_kill(params) #killer_id, victim_id, creator_is_killer=true)
    byebug
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
      kc.sender, kc.receiver = kc.receiver, kc.sender
    end
    kc
  end
    
end

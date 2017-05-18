class TeamRequest < ApplicationRecord
  enum status: [:pending, :accepted, :denied]
  belongs_to :reciever, class_name: "User"
  belongs_to :sender, class_name: "User"
  belongs_to :team

  def accept(user)
    if user == self.reciever && self.status == "pending" && self.team
      user.team = self.team
      self.status = :accepted
      user.save! && self.save!
    end
  end

  def deny(user)
    if user == self.reciever && self.status == "pending"
      self.status = "denied"
      self.save!
    end
  end
end

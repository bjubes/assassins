class TeamRequest < ApplicationRecord
  belongs_to :reciever, class_name: "User"
  belongs_to :sender, class_name: "User"
  belongs_to :team
end

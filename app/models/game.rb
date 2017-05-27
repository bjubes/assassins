class Game < ApplicationRecord
  validates :name, presence: true, length: {maximum: 40}
  belongs_to :owner, class_name: "User"
  has_many :users
  has_many :teams

  def invite_only?
    !code == nil
  end
end

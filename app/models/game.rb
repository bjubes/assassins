class Game < ApplicationRecord
  validates :name, presence: true, length: {maximum: 40}
  belongs_to :owner, class_name: "User"
  has_many :users
  has_many :teams
  before_destroy :release_users_from_game

  before_create do
      self.owner.game = self
    end

  def invite_only?
    !code == nil
  end

  def release_users_from_game
    self.users.each do |user|
      user.game_id = nil;
      user.save!
    end
  end

end

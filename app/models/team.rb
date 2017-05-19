class Team < ApplicationRecord
  has_many :users
  has_many :team_requests, foreign_key: "team_id"
  validates :name, uniqueness: true, presence: true, length: {maximum: 50}

  before_destroy :release_users_from_team

  #team.alive should never be called directly, use alive? instead.
  def alive?
    !self.out?
  end

  def out?
    return true if !self.alive
    if (self.hittime && self.hittime < 1.day.ago) #ensure hittime is not null and its over a day ago,
                                                  # '<' is confusing, but UNIX time is less -> happened earlier
      self.alive = false
      return true
    end
    false
  end

  def endangered?
    self.hittime && self.hittime > 1.day.ago
  end

  def status
    if !alive? then return "dead" end
    if endangered? then return "endangered" end
    "alive"
  end

  private
    def release_users_from_team
      self.users.each do |user|
        user.team_id = nil;
        user.save!
      end
    end

end

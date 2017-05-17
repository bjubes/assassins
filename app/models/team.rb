class Team < ApplicationRecord
  has_many :users
  has_many :team_requests, foreign_key: "team_id"
  validates :name, uniqueness: true, presence: true, length: {maximum: 50}
end

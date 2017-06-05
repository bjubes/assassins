class User < ApplicationRecord

  belongs_to :team, required: false
  belongs_to :game, required: false
  has_many :team_requests, class_name: "TeamRequest", foreign_key: "sender_id", dependent: :destroy
  has_many :team_requests, class_name: "TeamRequest", foreign_key: "reciever_id", dependent: :destroy
  has_many :kills, class_name: "Kill", foreign_key: "killer_id", dependent: :destroy
  has_many :deaths, class_name: "Kill", foreign_key: "victim_id", dependent: :destroy
  has_many :sent_kill_confirmations, class_name: "KillConfirmation", foreign_key: "sender_id", dependent: :destroy
  has_many :received_kill_confirmations, class_name: "KillConfirmation", foreign_key: "receiver_id", dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:twitter]

  validates :username, presence: true, length: {maximum: 99}, uniqueness: true

  before_save do 
    self.game = self.team.game
  end

  #for conventional purposes only
  def alive?
    self.alive
  end

  def self.from_omniauth(auth)
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    if !user
      user = User.new
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.save
    end
    user
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.valid? #causes validation checks and shows errors
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def exists?
    User.exists?(self.id)
  end
end

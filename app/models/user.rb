class User < ApplicationRecord

  belongs_to :team, required: false
  has_many :team_requests, class_name: "TeamRequest", foreign_key: "sender_id", dependent: :destroy
  has_many :team_requests, class_name: "TeamRequest", foreign_key: "reciever_id", dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:twitter]

  validates :username, presence: true, length: {maximum: 99}, uniqueness: true

  #for conventional purposes only
  def alive?
    self.alive
  end

  def self.from_omniauth(auth)
    where(auth.slice(provider: auth.provider, uid: auth.uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
    end
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
end

# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :tweets, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :follows, dependent: :destroy, foreign_key: :follower_id
  has_many :inverse_followers, dependent: :destroy, through: :follows
  has_many :inverse_follows,
           dependent: :destroy,
           foreign_key: :inverse_follower_id,
           class_name: Follow
  has_many :followers, dependent: :destroy, through: :inverse_follows
  has_many :conversations, dependent: :destroy, foreign_key: :sender_id

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[a-z][a-z0-9]+\z/ },
            length: { in: 4..24 }
  validates :screen_name, length: { maximum: 140 }
  validates :bio, length: { maximum: 200 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, length: { in: 6..24 }, if: :password
  validates :password_confirmation, presence: true, if: :password

  def followed_by?(user)
    inverse_follows.where(follower_id: user.id).exists?
  end
end

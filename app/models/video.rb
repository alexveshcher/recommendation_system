class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos

  # scope :seen_by_user, -> (user) { joins(:user_videos).where(user: user) }

  # scope :liked, -> () { where(like: true) }
  # scope :disliked, -> () { where(like: false) }
end

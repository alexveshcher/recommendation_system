class UserVideo < ApplicationRecord
  belongs_to :user
  belongs_to :video

  scope :liked, -> () { where(like: true) }
  scope :disliked, -> () { where(like: false) }

end

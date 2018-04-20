class User < ApplicationRecord

  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :recommendations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

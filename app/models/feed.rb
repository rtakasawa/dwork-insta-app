class Feed < ApplicationRecord
  mount_uploader :image, FeedUploader
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
end
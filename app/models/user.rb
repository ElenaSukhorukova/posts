class User < ApplicationRecord
  validates :login, presence: true

  has_many :posts
  has_many :ratings
end

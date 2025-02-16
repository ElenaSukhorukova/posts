class User < ApplicationRecord
  validates :login, presence: true, uniqueness: { case_sensitive: false }

  has_many :posts
  has_many :ratings
end

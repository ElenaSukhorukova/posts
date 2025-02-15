class Post < ApplicationRecord
  validates :title, presence: true, length: { in: 3..50 }
  validates :ip, presence: true, length: { in: 9..15 }
  validates :body, presence: true, length: { maximum: 5000 }

  belongs_to :user

  accepts_nested_attributes_for :user
end

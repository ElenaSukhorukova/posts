class Rating < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :value, presence: true, inclusion: { in: 1..5 }
  validate :validate_user_association, on: :create

  def self.post_has_rating(post_id)
    where(post_id: post_id).average(:value).to_f.floor(2) || 0
  end

  private

  def validate_user_association
    if Rating.where(post_id: post_id, user_id: user_id).any?
      errors.add(:user_id, I18n.t("activerecord.errors.rating.existence_user_rating_error"))
    end

    if Post.find(post_id).user_id == user_id
      errors.add(:user_id, I18n.t("activerecord.errors.rating.user_post_error"))
    end
  end
end

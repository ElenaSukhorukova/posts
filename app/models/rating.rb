class Rating < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validate :validate_user_association, on: :create

  after_create :update_avarage_rating

  private

  def validate_user_association
    if Rating.where(post_id: post_id, user_id: user_id).any?
      errors.add(:user_id, I18n.t('activerecord.errors.rating.existence_user_rating_error'))
    end

    if Post.find(post_id).user_id == user_id
      errors.add(:user_id, I18n.t('activerecord.errors.rating.user_post_error'))
    end
  end

  def update_avarage_rating
    Post.update(avarage_rating: Rating.post_has_rating(self.post_id).to_s)
  end

  def self.post_has_rating(post_id)
    where(post_id: post_id).average(:value).to_f.floor(2) || 0
  end
end

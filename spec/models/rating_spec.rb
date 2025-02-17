require 'rails_helper'

RSpec.describe Rating, type: :model do
  let(:rating) { build(:rating) }
  let(:post) { rating.post }

  describe 'validations' do
    it 'validates user_post_error' do
      rating.user = post.user

      expect(rating).to be_invalid
      expect(rating.errors[:user_id]).to include(I18n.t('activerecord.errors.rating.user_post_error'))
    end

    it 'validates existence_user_rating_error' do
      rating.save
      new_rating = Rating.new(value: rating.value, user_id: rating.user_id, post_id: rating.post_id)

      expect(new_rating).to be_invalid
      expect(new_rating.errors[:user_id]).to include(
        I18n.t('activerecord.errors.rating.existence_user_rating_error')
      )
    end

    it 'validate_value presence' do
      rating.value = nil

      expect(rating).to be_invalid
    end

    it 'validate_value range' do
      rating.value = 6

      expect(rating).to be_invalid
    end
  end
end

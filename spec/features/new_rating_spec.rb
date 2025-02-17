require 'rails_helper'

RSpec.describe 'Rating', type: :feature do
  let(:posts) { create_list(:post, 5) }
  let(:rating) { build(:rating) }

  describe 'rating' do
    it 'checks rating\'s change' do
      post = posts.first
      avr_post_rating = Rating.post_has_rating(post.id)
      user = posts.last.user

      visit root_path

      expect(page).to have_content I18n.t('posts.index.title')
      expect(page).to have_content post.title

      within("#new_rating_post_#{post.id}") do
        select("5", from: "rating_value")
        select(user.login, from: "rating_user_id")
        find('input[name="commit"]').click
      end

      expect(Rating.post_has_rating(post.id)).to_not eq(avr_post_rating)
    end

    it 'checks error flash' do
      post = posts.first
      avr_post_rating = Rating.post_has_rating(post.id)
      user = posts.first.user

      visit root_path

      within("#new_rating_post_#{post.id}") do
        select("5", from: "rating_value")
        select(user.login, from: "rating_user_id")
        find('input[name="commit"]').click
      end

      expect(page).to have_content(I18n.t('activerecord.errors.rating.user_post_error'))
    end
  end
end

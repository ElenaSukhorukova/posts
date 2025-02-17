require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  let(:post) { build(:post) }

  describe 'new' do
    it 'checks success flash' do
      visit new_post_path

      expect(page).to have_content I18n.t('posts.new.title')

      within('#new_post') do
        fill_in 'Title', with: post.title
        fill_in 'Body', with: post.body
        fill_in 'Ip', with: post.ip
        fill_in 'Login', with: 'NewUser'
      end

      click_button 'Create Post'

      expect(page).to have_content I18n.t('posts.create.success')
    end

    it 'checks error flash' do
      visit new_post_path

      expect(page).to have_content I18n.t('posts.new.title')

      within('#new_post') do
        fill_in 'Title', with: post.title
        fill_in 'Body', with: post.body
        fill_in 'Ip', with: post.ip
        fill_in 'Login', with: ' '
      end

      click_button 'Create Post'

      expect(page).to have_content(
        I18n.t('posts.create.error', msg: post.user.errors.full_messages.join('; '))
      )
    end
  end
end

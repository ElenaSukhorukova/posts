require 'rails_helper'

RSpec.describe FilteredPosts do
  let!(:rated_posts) { create_list(:rated_post, 5) }

  let(:params_limit_avarage_rating) {    {
      limit: 3,
      avarage_rating: Rating.post_has_rating(rated_posts.last.id)
    }
  }

  let(:params_ips) {
    {
      ips: rated_posts.first(3).pluck(:ip).join(',')
    }
  }

  describe '#call' do
    it 'checks posts without any filters' do
      operation = described_class.call({})
      last_post = rated_posts.last

      expect(operation.posts.dig(0, 'id')).to eq(last_post.id)
      expect(operation.posts[0]).to include(
        "id" => last_post.id,
        "title" => last_post.title,
        "body" => last_post.body
      )
    end

    it 'checks posts with filters: limit and avarage_rating' do
      operation = described_class.call(params_limit_avarage_rating)
      last_post = rated_posts.last

      included_post = operation.posts.find { |item| item['id'] == last_post.id }

      expect(included_post.present?).to eq(true)
      expect(included_post).to include(
        "id" => last_post.id,
        "title" => last_post.title,
        "avarage_ratings" => Rating.post_has_rating(rated_posts.last.id).to_s
      )
    end

    it 'checks posts with ips filter' do
      operation = described_class.call(params_ips)
      post = rated_posts.first

      pp operation.posts
      included_ip = operation.posts.find do |item|
        item.has_key?(post.ip)
      end

      expect(included_ip.present?).to eq(true)
      expect(included_ip).to include(
        post.ip => [post.user.login]
      )
    end
  end
end

module RatingsHelper
  def count_ratings(post_id)
    Rating.post_has_rating(post_id)
  end
end

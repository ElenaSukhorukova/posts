class FilteredPosts < Base
  attr_reader :posts

  def call
    limit = params[:limit]
    avarage_rating = params[:avarage_rating]
    ips = params[:ips]&.split(',')

    if [limit, avarage_rating, ips].all?(&:blank?)
      @posts = Post.order(created_at: :desc).as_json(only: [:id, :title, :body])

      return self
    end

    @posts = Post.joins(:user, :ratings)

    if ips.present?
      @posts = filter_by_ips(@posts, ips)

      return self
    end

    @posts = filter_by_avarage_ratings(@posts, avarage_rating) if avarage_rating.present?
    @posts = filter_by_limit(@posts, limit) if limit.present?

    @posts = @posts.as_json(only: [:id, :title, :body, :avarage_ratings])

    self
  end

  private

  def filter_by_avarage_ratings(posts, avarage_rating)
    posts.select('posts.*').merge(
      Rating.select('post_id, AVG(value) AS avarage_ratings')
            .group('post_id')
            .having('AVG(value) = ?', avarage_rating)
    ).group('posts.id').order(created_at: :desc)
  end

  def filter_by_limit(posts, limit)
    posts.limit(limit)
  end

  def filter_by_ips(posts, ips)
    posts = posts.where(ip: ips)
                 .select('posts.ip, users.login')
                 .group('posts.ip, users.login')

    posts_result = []

    posts.each do |post|
      if posts_result.find { |item| item.is_a?(Hash) && item[post.ip] }
        posts_result = map_results(post, posts_result)
      else
        posts_result.push({ post.ip => [] })

        posts_result = map_results(post, posts_result)
      end
    end

    posts_result
  end

  def map_results(post, results)
    results.map do |item|
      item[post.ip] && item[post.ip].push(post.login).uniq!

      item
    end
  end
end

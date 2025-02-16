class FilteredPosts < Base
  attr_reader :posts

  def call
    @posts = params[:posts]

    limit = params.dig(:params, :limit)
    avarage_rating = params.dig(:params, :avarage_rating)
    ips = params.dig(:params, :ips)&.split(',')

    if [limit, avarage_rating, ips].all?(&:blank?)
      @posts = @posts.order(created_at: :desc).as_json(only: [:id, :title, :body])

      return self
    end

    if ips.present?
      binding.pry
      return @posts.where(ip: ips).pluck('posts.ip', 'users.login')
    end

    @posts = @posts.where(avarage_rating: avarage_rating.to_s).order(created_at: :desc) if avarage_rating.present?
    @posts = @posts.limit(limit) if limit.present?

    @posts = @posts.as_json(only: [:id, :title, :body, :avarage_rating])

    self
  end
end

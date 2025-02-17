class RatingsController < ApplicationController
  include ActionView::RecordIdentifier

  def create
    user = User.find_by(id: rating_params[:user_id])
    post = Post.find_by(id: rating_params[:post_id])

    validate_user_and_post(user, post) { |mgs| return exec_respond_to(mgs) }

    rating = user.ratings.build(rating_params)

    return exec_respond_to(retrieve_full_error_message(rating)) unless rating.save

    respond_to do |format|
      format.json do
        render json: {
          status: :ok,
          avarage_rating: Rating.post_has_rating(post.id),
          post_id: post.id
        }
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "#{dom_id(post)}_ratings_count",
          partial: 'ratings/rating',
          locals: { post: post }
        )
      end
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:user_id, :post_id, :value)
  end

  def validate_user_and_post(user, post)
    msg = if user.blank?
        t('.user_error')
      elsif post.blank?
        t('.post_error')
      end

    return if msg.blank?

    yield(msg) if block_given?
  end

  def exec_respond_to(mgs)
    Proc.new do |message|
      respond_to do |format|
        format.json { render json: { status: :bad_request, error: mgs } }
        format.html { redirect_to(root_path, danger: message) }
        format.turbo_stream { flash.now[:danger] = message }
      end
    end.call(mgs)
  end
end

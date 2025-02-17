class PostsController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        posts = Post.includes(:user, :ratings)

        @pagy, @posts = pagy(posts, limit: 6)
        @users = posts.extract_associated(:user)
      end
      format.json do
        posts = FilteredPosts.call(params).posts

        render json: posts
      end
    end
  end

  def new
    @post = Post.new
    @user = @post.build_user
  end

  def create
    @user = User.find_or_initialize_by(post_params[:user_attributes])

    if @user.new_record? && !@user.save
      @post = Post.new

      return exec_bad_request_response(t('.error', msg: retrieve_full_error_message(@user)))
    end

    @post = @user.posts.new(post_params)

    if @post.save
      respond_to do |format|
        format.html { redirect_to(posts_path, success: t('.success')) }
        format.json { render json: { status: :ok, user: @user, post: @post } }
      end and return
    end

    exec_bad_request_response(retrieve_full_error_message(@post))
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :ip, user_attributes: %i[login])
  end

  def exec_bad_request_response(error)
    Proc.new do |msg|
      respond_to do |format|
        format.json { render json: { status: :bad_request, error: msg } }
        format.html do
          flash.now[:danger] = msg

          render :new, status: :bad_request
        end
      end
    end.call(error)
  end
end

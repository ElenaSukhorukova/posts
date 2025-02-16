class PostsController < ApplicationController
  def index
    @pagy, @posts = pagy(Post.includes(:user, :ratings), limit: 6)
    @users = User.all
  end

  def new
    @post = Post.new
    @user = @post.build_user
  end

  def create
    @user = User.find_or_initialize_by(post_params[:user_attributes])

    if @user.new_record? && !@user.save
      flash.now[:danger] = t('.error', msg: retrieve_full_error_message(@user))

      @post = Post.new

      render(:new, status: :bad_request) and return
    end

    @post = @user.posts.new(post_params)

    if @post.save
      redirect_to(posts_path, success: t('.success')) and return
    end

    flash.now[:danger] = t('.error', msg: retrieve_full_error_message(@post))

    render :new, status: :bad_request
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :ip, user_attributes: %i[login])
  end
end


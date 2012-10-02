class PostsController < ApplicationController
  before_filter :authorize

  before_filter :find_post, only: [:show, :edit, :destroy, :update]
  before_filter :find_posts, only: :index
  before_filter :create_markdown, only: [:show, :index, :tagged]
  before_filter :build_comment, only: [:show]

  def create
    @post = current_user.publish(params[:post])

    if @post.persisted?
      successful_create_update
    else
      render "new"
    end
  end

  def index

  end

  def new
    @post = Post.new
  end

  def show
    @comments = @post.comments.paginate(page: params[:page])
  end

  def edit
    redirect_to @post unless @post.user==current_user
  end

  def update
    if @post.update_attributes(params[:post])
      successful_create_update
    else
      render "edit"
    end
  end

  def destroy
    redirect_to @post.delete_by_author(current_user) ?  posts_path : @post
  end

  private

  def find_post
    @post = Post.find(params[:id]) || not_found
  end

  def find_posts
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).paginate(page: params[:page], order: "created_at DESC")
    else
      @posts = Post.paginate(page: params[:page], order: "created_at DESC")
    end
  end

  def successful_create_update
    redirect_to @post, notice: "Post #{@post.title} was successfully edited."
  end

  def build_comment
    @comment = @post.comments.build()
  end

end

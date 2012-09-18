#require "admin/AdminController"
class Admin::PostsController < Admin::AdminController
  before_filter :admin_authorize, :create_markdown
  before_filter :find_post, only: [:show, :edit, :destroy, :update]

  def index
    @posts = Post.paginate(page: params[:page])
  end

  def show
    @comments = @post.comments.paginate(page: params[:page])
  end

  def edit
  end

  def destroy
    redirect_to @post.delete_by_admin ? admin_posts_path : @post
  end

  def create
  end

  def new
  end

  def update

    if  @post.update_by_admin(params[:post])
      successful_create_update
    else
      render "edit"
    end
  end

  private
  def find_post
    @post = Post.find(params[:id])
  end

  def successful_create_update
    redirect_to [:admin, @post], notice: "Post #{@post.title} was successfully edited."
  end
end

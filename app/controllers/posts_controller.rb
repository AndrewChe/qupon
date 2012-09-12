class PostsController < ApplicationController
  before_filter :authorize

  before_filter :find_by_id, only: [:show, :edit, :destroy, :update]
  before_filter :create_markdown, only: [:show, :index]

  def create
    create_post
  end

  def index
    @posts = Post.where("post_type = 'post'")
  end

  def new
    @post = Post.new
  end

  def show
    post_not_comment(@post)
    @comment = Post.new(title: "comment", post_id: @post.id)
  end

  def edit

  end

  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        successful_create_update(format)
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      if @post.comment?
        format.html { redirect_to @post.post }
      else
        format.html { redirect_to '/' }
      end
    end
  end

  private
  def find_by_id
    @post = Post.find(params[:id]) || not_found
  end

  def create_post
    @post = Post.create(params[:post])
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        successful_create_update(format)
      else
        format.html { render action: "new" }
      end
    end
  end

  def successful_create_update(format)
    if @post.comment?
      format.html { redirect_to @post.post, notice: "Comment was successfully edited." }
    else
      format.html { redirect_to @post, notice: "Post #{@post.title} was successfully edited." }
    end
  end

  def post_not_comment(post)
    if (post.comment?)
      not_found
    end
  end
end

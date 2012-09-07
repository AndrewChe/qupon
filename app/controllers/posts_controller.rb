class PostsController < ApplicationController
  before_filter :authorize

  before_filter :find_by_id, only: [:show, :edit, :destroy, :update]

  def create
    @post = Post.create(params[:post])
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to '/', notice: 'Post #{ @post.title} was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def index
    @posts = Post.all

  end

  def new
    @post = Post.new
  end

  def show
  end

  def edit

  end

  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to '/', notice: "Post #{@post.title} was successfully edited." }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to "/" }
    end
  end

  private
  def find_by_id
    @post = Post.find(params[:id])
  end
end

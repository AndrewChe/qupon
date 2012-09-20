class CommentsController < ApplicationController
  before_filter :find_parent
  before_filter :find_comment, only: [:destroy, :update, :edit]
#  after_filter :redirect_to_post, only: [:destroy, :update]

  def new
    @comment = @parent.comments.build(params[:comment])
  end

  def create
    @comment = current_user.leave_comment(params[:comment], @parent)
    redirect_to_post
  end

  def destroy
    @comment.delete(current_user)
    redirect_to_post
  end

  def edit
    @post = @comment.post
  end

  def update
    @comment.edit_comment(current_user, params[:comment])
    redirect_to_post
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def find_parent
    @parent = Post.find_by_id(params[:post_id]) if params[:post_id]
    @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id]

    redirect_to :back unless defined?(@parent)
  end

  def redirect_to_post
    redirect_to @comment.post
  end
end

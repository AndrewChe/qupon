class Admin::CommentsController < Admin::AdminController
  before_filter :admin_authorize, :find_comment

  def edit
  end

  def update
    @comment.update_by_admin(params[:comment])
    redirect_to [:admin, @comment.post]
  end

  def destroy
    @comment.delete_by_admin
    redirect_to [:admin, @comment.post]
  end

  private
  def find_comment
    @comment = Comment.find(params[:id])
  end

end

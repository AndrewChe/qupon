class Admin::UsersController < Admin::AdminController
  before_filter :admin_authorize
  before_filter :find_user, only: [:show, :destroy, :edit, :update]
  before_filter :create_markdown, only: :show

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @posts = @user.posts
    @comments = @user.comments
  end

  def destroy
    @user.delete_by_admin
    redirect_to admin_users_path
  end

  def update
    if @user.update_by_admin(params[:user])
      redirect_to admin_users_path
    else
      render :edit
    end

  end

  def edit
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end

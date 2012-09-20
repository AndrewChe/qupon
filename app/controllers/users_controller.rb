class UsersController < ApplicationController
  before_filter :authorize, except: [:new, :create]
  before_filter :find_user, only: [:show, :edit, :destroy, :update]
  before_filter :create_markdown, only: :show

  def create
    @user = User.new(params[:user])

    if @user.save
      sign_in(@user)
      redirect_to posts_path, notice: 'User #{ @user.name} was successfully created.'
    else
      render "new"
    end
  end

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @posts = @user.posts
    @comments = @user.comments
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to users_path(@user)
    else
      render "edit"
    end
  end

  def destroy
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end

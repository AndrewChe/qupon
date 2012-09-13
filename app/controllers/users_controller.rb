class UsersController < ApplicationController
  before_filter :authorize, except: [:new, :create]
  before_filter :find_user, only: [:show, :edit, :destroy]
  before_filter :create_markdown, only: :show

  def create
    @user = User.new(params[:user])

      if @user.save
        sign_in(@user)
        redirect_to posts_path, notice: 'User #{ @user.name} was successfully created.'
      else
        render action: "new"
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
  end

  def destroy
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end

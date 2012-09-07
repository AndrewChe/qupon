class UsersController < ApplicationController
  before_filter :find_by_id, only: [:show, :edit, :destroy]


  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'User #{ @user.name} was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_by_id
    @user = User.find(params[:id])
  end
end

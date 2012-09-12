require 'spec_helper'
require 'factories/factories'

describe UsersController do
  let!(:user) {create(:user)}
  let!(:post) {create(:post, user_id: user.id)}
  let!(:comment) {create(:comment, user_id: user.id, post_id: post.id)}

  before(:each) do
    sign_in_as(user)
  end

  describe "index" do
    it "should show all users" do
      get :index
      assigns(:users).should eq([user])
    end
  end

  describe "show" do
    it "should show user with all post and comments from him" do
      get :show, {id: user.id}
      assigns(:user).should eq(user)
      assigns(:posts).should eq([post])
      assigns(:comments).should eq([comment])
    end
  end
end
require 'spec_helper'
require 'factories/factories'

describe PostsController do
  let!(:user) {create(:user)}
  let!(:post) {create(:post, user_id: user.id)}
  let!(:comment) {create(:comment, user_id: user.id, post_id: post.id)}

  before(:each) do
    sign_in_as(user)
  end

  describe "index" do
    it "should show all posts that isn't comment" do
      get :index
      assigns(:posts).should eq([post])
    end
  end

  describe "show" do
    it "should show post with comments" do
      get :show, {id: post.id}
      assigns(:post).should eq(post)
      assigns(:post).posts.should eq([comment])
    end
  end
end
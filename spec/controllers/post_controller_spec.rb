require 'spec_helper'
require 'factories/factories'

describe PostsController do
  let!(:user) { create(:user) }
  let!(:article) { create(:post, user: user) }
  let!(:comment) { create(:comment, user: user, post: article) }

  before(:each) do
    sign_in_as(user)
  end

  describe "index" do
    it "should show all posts that isn't comment" do
      get :index
      assigns(:posts).should eq([article])
    end
  end

  describe "show" do
    it "should show post with comments" do
      get :show, {id: article.id}
      assigns(:post).should eq(article)
      assigns(:post).posts.should eq([comment])
    end
  end
end

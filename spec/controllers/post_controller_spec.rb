require 'spec_helper'
require 'factories/factories'

describe PostsController do
  let!(:pupkin) { create(:user) }
  let!(:article) { create(:post, user: pupkin) }
  let!(:comment) { create(:comment, commentable: article, user: pupkin)}

  before(:each) do
    sign_in_as(pupkin)
  end

  describe "index" do
    it "should show all posts" do
      get :index
      assigns(:posts).should eq([article])
    end
  end

  describe "show" do
    it "should show post with comments" do
      get :show, { id: article.id }
      assigns(:post).should eq(article)
      assigns(:comments).should eq([comment])
    end
  end

  describe "#create" do

    def do_post(attrs = { })
      options = { title: "Some title", body: "Body body" }.merge(attrs)
      post :create, post: options
    end

    context "when post params are valid" do
      it "should create user's post" do
        expect { do_post }.to change { pupkin.posts.count }.by(1)
      end
    end
  end
end

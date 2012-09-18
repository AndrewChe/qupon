require 'spec_helper'

describe Admin::PostsController do

  let!(:pupkin) { create(:user, admin: true) }
  let!(:hacker) { create(:user, email: "hacker@hack.er") }
  let!(:article) { create(:post, user_id: hacker.id) }
  let!(:comment) { create(:comment, user_id: hacker.id, post_id: article.id) }

  describe "GET 'index'" do
    context "user is admin"

    it "shows all posts" do
      sign_in_as(pupkin)
      get 'index'
      assigns(:posts).should eq([article])
    end

    context "user isn't admin"
    it "redirect to sign_in" do
      sign_in_as(hacker)
      get 'index'
      response.should redirect_to(posts_path)
    end
  end

  describe "DESTROY post" do
    context "user is admin"
    it "should delete post with comments" do
      sign_in_as(pupkin)
      expect { delete :destroy, id: article.id }.to change { Post.count }.by(-1)

    end

    context "user isn't admin"
    it "should NOT delete post" do
      sign_in_as(hacker)
      expect { delete :destroy, id: article.id }.to_not change { Post.count }

    end
  end

  describe "UPDATE post" do
    new_title = "new title"

    context "user is admin"
    it "should update post params" do
      sign_in_as(pupkin)

      expect { put :update, id: article.id, post: {title: new_title}}.to change { Post.find(article.id).title}.to(new_title)
    end

    context "user isn't admin"
    it "should update post params" do
      sign_in_as(hacker)
      expect { put :update, id: article.id, post: { title: new_title } }.to_not change { Post.find(article.id).title }.to(new_title)
    end
  end

end

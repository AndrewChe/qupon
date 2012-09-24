require 'spec_helper'

describe Admin::CommentsController do

  let!(:pupkin) { create(:user, admin: true) }
  let!(:hacker) { create(:user, email: "hacker@hack.er") }
  let!(:article) { create(:post, user_id: hacker.id) }
  let!(:comment) { create(:comment, user_id: hacker.id, commentable: article) }
  let!(:reply) { create(:comment, user_id: hacker.id, commentable: comment)}

  describe "DESTROY comment" do
    context "user is admin"
    it "should delete comment" do
      sign_in_as(pupkin)
      expect { delete :destroy, id: article.id }.to change { Comment.count }.by(-2)

    end

    context "user isn't admin"
    it "should NOT delete comment" do
      sign_in_as(hacker)
      expect { delete :destroy, id: article.id }.to_not change { Comment.count }

    end
  end

  describe "UPDATE comment" do
    new_body = "new body"

    context "user is admin"
    it "should update comment params" do
      sign_in_as(pupkin)

      expect { put :update, id: article.id, comment: { body: new_body } }.to change { Comment.find(article.id).body }.to(new_body)
    end

    context "user isn't admin"
    it "should update comment params" do
      sign_in_as(hacker)
      expect { put :update, id: article.id, comment: { body: new_body } }.to_not change { Comment.find(article.id).body }.to(new_body)
    end
  end

end

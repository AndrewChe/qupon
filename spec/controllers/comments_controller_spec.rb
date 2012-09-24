require 'spec_helper'

describe CommentsController do

  let!(:pupkin) { create(:user) }
  let!(:article) { create(:post, user: pupkin) }
  let!(:comment) { create(:comment, user: pupkin, commentable: article)}


  before(:each) do
    sign_in_as(pupkin)
  end

  describe "GET 'create'" do

    def do_comment(attrs = { }, parent = { })
      options =  { body: "Body body" }.merge(attrs)
      post :create, {comment: options}.merge(parent)
    end

    context "when comment params are valid" do
      it "should create user's comment" do
        expect { do_comment({}, post_id: article.id) }.to change { pupkin.comments.count }.by(1)
      end

      it "should create a reply" do
        expect { do_comment({}, comment_id: comment.id) }.to change { comment.comments.count}.by(1)
      end
    end
  end

end

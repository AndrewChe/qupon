require 'spec_helper'

describe CommentsController do

  let!(:pupkin) { create(:user) }
  let!(:article) { create(:post, user: pupkin) }


  before(:each) do
    sign_in_as(pupkin)
  end

  describe "GET 'create'" do

    def do_comment(attrs = { })
      options =  { body: "Body body" }.merge(attrs)
      post :create, {comment: options}.merge( post_id: article.id)
    end

    context "when comment params are valid"
      it "should create user's comment" do
        expect { do_comment }.to change { pupkin.comments.count }.by(1)
      end
  end

end

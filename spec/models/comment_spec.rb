require 'spec_helper'

describe Comment do
  let!(:pupkin) { create(:user) }
  let!(:hacker) { create(:user, email: "hacker@p.com") }
  let!(:article) { create(:post, user: pupkin) }
  let!(:comment) { create(:comment, commentable: article, user: pupkin) }

  it "should delete itself if it was created by current user" do
    expect { comment.delete(pupkin) }.to change { Comment.count }.by(-1)
  end

  it "should NOT delete itself if it was created by another user" do
    expect { comment.delete(hacker) }.to change { Comment.count }.by(0)
  end

  it "should edit itself if it was created by current user" do
    expect { comment.edit_comment(pupkin, body: "new body") }.to change {comment.body}.to ("new body")
  end

  it "should NOT edit itself if it was created by another user" do
    expect { comment.edit_comment(hacker, body: "new body" ) }.not_to change { comment.body }.to ("new body")
  end


end

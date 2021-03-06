require 'spec_helper'

describe Post do

  let!(:pupkin) { create(:user) }
  let!(:hacker) { create(:user, email: "hacker@p.com") }
  let!(:article) { create(:post, user: pupkin) }
  let(:comment) { create(:comment, commentable: article, user: pupkin) }

  it "should delete itself if it was created by current user" do
    expect {article.delete_by_author(pupkin)}.to change {Post.count}.by(-1)
  end

  it "should NOT delete itself if it was created by another user" do
    expect { article.delete_by_author(hacker) }.to change { Post.count }.by(0)
  end

  it "should NOT delete itself if it has any comments" do
    comment
    expect { article.delete_by_author(pupkin) }.to change { Post.count }.by(0)
  end

end

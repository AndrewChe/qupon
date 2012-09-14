require 'spec_helper'

describe User do

  let!(:pupkin) { create(:user) }
  let(:article) { create(:post, user: pupkin) }

  it "should publish post" do
    expect { pupkin.publish({title: "some title", body: "some body" }) }.to change { Post.count }.by(1)
  end

  it "should leave comment" do
    expect { pupkin.leave_comment(body: "some comment", post: article) }.to change { Comment.count }.by(1)
  end

end

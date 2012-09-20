class RssFeedController < ApplicationController
  before_filter :authorize
  layout false

  def feed
    @posts = Post.all(order: "created_at DESC", limit: 10)
    respond_to do |format|
      format.rss
    end
  end
end

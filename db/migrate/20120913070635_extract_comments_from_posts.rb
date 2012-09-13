class ExtractCommentsFromPosts < ActiveRecord::Migration
  def up
    Post.where(post_type: :comment).each do |post|
      say "Creating comment from post #{post.id}"
      Comment.create({body: post.body, user: post.user, post: post.post}, without_protection: true)
      post.destroy
    end

  end

  def down
    Comment.delete_all
  end
end

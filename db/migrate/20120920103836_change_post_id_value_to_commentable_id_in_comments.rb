class ChangePostIdValueToCommentableIdInComments < ActiveRecord::Migration
  def up
    Comment.all.each do |comment|
      comment.commentable_id = comment.post_id
      comment.commentable_type = "Post"
      comment.save
    end
  end

  def down
    Comment.update_all(commentable_id: nil, commentable_type: nil)
  end
end

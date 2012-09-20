class RemoveCommentIdPostIdFromComments < ActiveRecord::Migration
  def up
    remove_column :comments, :comment_id
    remove_column :comments, :post_id
  end

  def down
    add_column :comments, :post_id, :integer
    add_column :comments, :comment_id, :integer
  end
end

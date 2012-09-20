class RemoveCommentsIndexOnPostId < ActiveRecord::Migration
  def up
    remove_index "comments", ["post_id"]
  end

  def down
    add_index "comments", ["post_id"]
  end
end

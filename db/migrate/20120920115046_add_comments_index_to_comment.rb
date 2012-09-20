class AddCommentsIndexToComment < ActiveRecord::Migration
  def change

    add_index :comments, [:commentable_id, :commentable_type], name: "index_comments_on_commentable_id_and_type"
  end
end

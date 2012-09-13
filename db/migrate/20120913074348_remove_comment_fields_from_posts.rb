class RemoveCommentFieldsFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :post_type, :post_id
  end

  def self.down
    add_column :posts, :post_type, :string
    add_column :posts, :post_id, :integer
  end
end

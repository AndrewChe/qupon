class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.belongs_to :user, null: false
      t.belongs_to :post, null: false

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :post_id
  end
end

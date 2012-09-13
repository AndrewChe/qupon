class Post < ActiveRecord::Base
  attr_accessible :body, :title, :post_type, :user_id, :user, :post, :posts, :post_id
  belongs_to :user
  has_many :posts
  belongs_to :post

  validates :title, :body, presence: true
  validates :title, length: { :maximum => 100 }

  def comment?
    post_type == "comment"
  end
end

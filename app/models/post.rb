class Post < ActiveRecord::Base
  attr_accessible :body, :title
  belongs_to :user
  has_many :comments

  validates :title, :body, presence: true
  validates :title, length: { :maximum => 100 }
  validates :user_id, presence: true

  def comment?
    post_type == "comment"
  end
end

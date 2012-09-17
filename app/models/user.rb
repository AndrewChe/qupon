class User < ActiveRecord::Base

  include Clearance::User

  attr_accessible :last_name, :name, :nick_name, :photo, :password, :email
  has_many :posts
  has_many :comments

  validates :name, presence: true

  def publish(params)
    self.posts.create(params)
  end

  def leave_comment(comment_params, post)
    self.comments.build(comment_params).tap do |comment|
      comment.post = post
      comment.save
    end
  end

end

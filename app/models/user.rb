class User < ActiveRecord::Base

  include Clearance::User

  attr_accessible :last_name, :name, :nick_name, :photo, :password, :email
  has_many :posts
  has_many :comments

  validates :name, presence: true

  def publish(params)
    self.posts.create(params)
  end

  def leave_comment(params)
    self.comments.create(params, without_protection: true)
  end

end

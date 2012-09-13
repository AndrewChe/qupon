class User < ActiveRecord::Base

  include Clearance::User

  attr_accessible :last_name, :name, :nick_name, :photo, :password, :email
  has_many :posts

  validates :name, presence: true

  def publish(params)
    self.posts.new(params)
  end
end

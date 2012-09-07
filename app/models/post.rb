class Post < ActiveRecord::Base
  attr_accessible :body, :title, :type, :user_id, :user
  belongs_to :user

  validates :title, :body, presence: true
end

class Post < ActiveRecord::Base
  attr_accessible :body, :title
  belongs_to :user
  has_many :comments

  before_destroy :ensure_have_not_comments

  validates :title, :body, presence: true
  validates :title, length: { maximum: 100 }
  validates :user_id, presence: true

  self.per_page = 3

  def delete(current_user)
    self.destroy    if user==current_user
  end

  private

  def ensure_have_not_comments
     if comments.any?
       errors.add(:base, 'Comments present. You cannot delete post')
       false
     end
  end
end

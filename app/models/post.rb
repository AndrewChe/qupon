class Post < ActiveRecord::Base
  attr_accessible :body, :title
  belongs_to :user
  has_many :comments, as: :commentable

  before_destroy :ensure_have_not_comments

  validates :title, :body, presence: true
  validates :title, length: { maximum: 100 }
  validates :user_id, presence: true

  self.per_page = 10

  def delete(current_user)
    self.destroy    if user==current_user
  end

  def delete_by_admin
    commentable.destroy_all
    self.destroy
  end

  def update_by_admin(options)
    self.update_attributes(options)
  end

  private

  def ensure_have_not_comments
     if commentable.any?
       errors.add(:base, 'Comments present. You cannot delete post')
       false
     end
  end
end

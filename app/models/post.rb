class Post < ActiveRecord::Base
  attr_accessible :body, :title
  belongs_to :user
  has_many :comments

  before_destroy :ensure_have_not_comments

  validates :title, :body, presence: true
  validates :title, length: { :maximum => 100 }
  validates :user_id, presence: true


  def delete(current_user)
    if user==current_user
      self.destroy
    end
    false
  end

  private

  def ensure_have_not_comments
     if comments.any?
       errors.add(:base, 'Comments present. You cannot delete post')
       false
     end
  end
end

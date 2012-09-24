class Post < ActiveRecord::Base

  acts_as_taggable

  attr_accessible :body, :title, :tag_list
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
    if comments.any?
      comments.each do |comment|
        comment.delete_by_admin
      end
    end
    self.destroy
  end

  def update_by_admin(options)
    self.update_attributes(options)
  end

  def comments_count
    count = 0
    if comments.any?
      comments.each do |comment|
        count += comment.all_reply_count
      end
    end
    count += comments.size
  end

  private

  def ensure_have_not_comments
     if comments(true).any?
       errors.add(:base, 'Comments present. You cannot delete post')
       false
     end
  end
end

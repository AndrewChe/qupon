class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  attr_accessible :body

  before_destroy :ensure_not_contain_comments

  validates :body, presence: true

  self.per_page = 5

  def edit_comment(current_user, comment_params)
    self.update_attributes(comment_params) if author?(current_user)
  end

  def author?(user)
    self.user == user
  end

  def delete_by_author(current_user)
    self.destroy if author?(current_user)
  end

  def all_reply_count
    count = 0
    if comments.any?
      comments.each do |comment|
        count += comment.all_reply_count
      end
    end
    count += comments.size
  end

  def parent_post_title
    parent_post.title
  end

  def post
    return @post if defined?(@post)
    @post = commentable.is_a?(Post) ? commentable : commentable.post
  end

  def update_by_admin(options = {})
    self.update_attributes(options)

  end

  def delete_by_admin
    delete_all_by_admin
    self.destroy
  end

  def delete_all_by_admin
    if comments.any?
      comments.each do |comment|
        comment.delete_all_by_admin
      end
    end
    self.destroy
  end

  private

  def ensure_not_contain_comments

    false if comments(true).any?

  end

end

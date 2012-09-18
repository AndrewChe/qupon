class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  attr_accessible :body

  validates :body, presence: true

  self.per_page = 5

  def edit_comment(current_user, comment_params)
    self.update_attributes(comment_params) if author?(current_user)
  end

  def author?(user)
    self.user == user
  end

  def delete(current_user)
    self.destroy if author?(current_user)
  end

  def parent_post_title
    post.title
  end

  def update_by_admin(options = {})
    self.update_attributes(options)

  end

  def delete_by_admin
    self.destroy
  end
end

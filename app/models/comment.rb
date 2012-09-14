class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  attr_accessible :body

  validates :body, presence: true

  self.per_page = 15

  def edit_comment(current_user, comment_params)
    self.update_attributes(comment_params) if self.user==current_user
  end

  def delete(current_user)
    self.destroy if user==current_user
  end

end

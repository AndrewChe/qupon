class User < ActiveRecord::Base

  before_destroy :ensure_not_admin_or_present_another_admin

  include Clearance::User

  self.per_page = 15

  attr_accessible :last_name, :name, :nick_name, :photo, :password, :email

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }

  has_many :posts
  has_many :comments

  validates :name, presence: true

  def publish(params)
    self.posts.create(params)
  end

  def leave_comment(comment_params, parent)
    self.comments.build(comment_params).tap do |comment|
      comment.commentable = parent
      comment.save
    end
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def delete_by_admin
    self.destroy
  end

  def update_by_admin(options = {})
    if options.has_key?(:admin)
      if options[:admin]==true || ensure_not_admin_or_present_another_admin
        self.admin=options[:admin]
      else
        return false
      end
      options.delete(:admin)
    end
    self.update_attributes(options)
  end


  private

  def ensure_not_admin_or_present_another_admin
    if self.admin? && not_exist_admins_without_me?
        errors.add(:base, 'Another admins absent. You cannot delete the last admin')
        return false
    end
    true
  end

  def not_exist_admins_without_me?
    User.where("id <> ? and admin = ?", self.id, true).none?
  end
end

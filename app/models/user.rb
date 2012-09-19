class User < ActiveRecord::Base

  before_destroy :ensure_not_admin_or_present_another_admin

  include Clearance::User

  self.per_page = 15

  attr_accessible :last_name, :name, :nick_name, :photo, :password, :email, :admin
  has_many :posts
  has_many :comments

  validates :name, presence: true

  def publish(params)
    self.posts.create(params)
  end

  def leave_comment(comment_params, post)
    self.comments.build(comment_params).tap do |comment|
      comment.post = post
      comment.save
    end
  end

  def delete_by_admin
    self.destroy
  end

  def update_by_admin(options = {})
    if options.has_key?(:admin)
      if options[:admin]
        self.admin=options[:admin]
      else
        self.admin=options[:admin] if ensure_not_admin_or_present_another_admin
      end
      options.delete(:admin)
    end
    self.update_attributes(options)
  end


  private

  def ensure_not_admin_or_present_another_admin
    if self.admin?
      if User.find_all_by_admin(true).count <=1
        errors.add(:base, 'Another admins absent. You cannot delete the last admin')
        return false
      end
    end
    true
  end

end

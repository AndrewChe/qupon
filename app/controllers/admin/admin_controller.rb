class Admin::AdminController < ApplicationController
  before_filter :authorize
  layout 'admin'


  def admin_authorize
    #authorize
    redirect_to(posts_path) unless current_user.admin?
  end
end

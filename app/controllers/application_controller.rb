class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery

  def create_markdown
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
